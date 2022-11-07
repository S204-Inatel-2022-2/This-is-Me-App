import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:this_is_me/model/character.dart';
import 'package:http/http.dart' as http;
import 'package:this_is_me/model/exception/response_exception.dart';

Future<Character> loginUser(
  http.Client client,
  String email,
  String password,
) async {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;
  final response = await client.post(
      Uri.parse('https://timeapibyredfoxghs.herokuapp.com/user/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }));

  // if (response.statusCode != 302) {
  //   return response.body;
  // }
  final getCharacterPath = Uri.parse(response.headers['location'].toString());
  final getCharacterToken = response.headers['set-cookie'];
  final character = await client.get(getCharacterPath, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Cookie': '$getCharacterToken',
  });

  // prefs.setString('token', getCharacterToken.toString());

  print('body');
  print(character.body);
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
        'email': email,
        'password': password,
        'verifyPassword': passwordAgain,
        'characterName': username
      }));

  if (response.statusCode != 201) {
    return ResponseException.fromJson(
        jsonDecode((utf8.decode(response.bodyBytes))));
  }

  return response.statusCode;
}

Future<String> loadCharacter(
  http.Client client,
  String token,
) async {
  final response = await client.get(
      Uri.parse(
          'https://timeapibyredfoxghs.herokuapp.com/character/get-character'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Cookie': token,
      });

  return response.body;
}
