import 'dart:convert';
import 'package:this_is_me/model/character.dart';
import 'package:http/http.dart' as http;
import 'package:this_is_me/model/exception/response_exception.dart';

Future<dynamic> loginUser(
  http.Client client,
  String email,
  String password,
) async {
  final response = await client.post(
      Uri.parse('https://timeapibyredfoxghs.herokuapp.com/user/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }));

  if (response.statusCode != 302) {
    return response.body;
  }
  final getCharacterPath = Uri.parse(response.headers['location'].toString());
  final getCharacterToken = response.headers['set-cookie'];
  final character = await client.get(getCharacterPath, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Cookie': '$getCharacterToken',
  });

  return Character.fromJson(jsonDecode(character.body));
}

Future<dynamic> signUpUser(http.Client client, String username, String email,
    String password, String passwordAgain) async {
  final response = await client.post(
      Uri.parse('https://timeapibyredfoxghs.herokuapp.com/user/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'userDtoInput': {'email': email, 'password': password},
        'verifyPassword': passwordAgain,
        'characterName': username,
        'sex': null
      }));

  if (response.statusCode != 201) {
    return ResponseException.fromJson(jsonDecode(response.body)).message;
  }

  return response.statusCode;
}
