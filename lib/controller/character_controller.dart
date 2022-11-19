import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:this_is_me/model/character.dart';
import 'package:this_is_me/model/exception/response_exception.dart';

Future<dynamic> setClothes(http.Client client, int number) async {
  final Future<SharedPreferences> preferences = SharedPreferences.getInstance();
  final SharedPreferences prefs = await preferences;
  final String? token = prefs.getString('token');
  number = number + 1;
  final response = await http.post(
      Uri.parse('https://timeapibyredfoxghs.herokuapp.com'
          '/character/set-clothes?number=$number'),
      headers: {
        'Content-Type': 'application/json',
        'Cookie': token!,
      });

  if (response.statusCode != 200) {
    return ResponseException.fromJson(
        jsonDecode((utf8.decode(response.bodyBytes))));
  }
  return response.statusCode;
}

Future<dynamic> getCharacter(http.Client client) async {
  final Future<SharedPreferences> preferences = SharedPreferences.getInstance();
  final SharedPreferences prefs = await preferences;
  final String? token = prefs.getString('token');

  final response = await http.get(
      Uri.parse(
          'https://timeapibyredfoxghs.herokuapp.com/character/get-character'),
      headers: {
        'Content-Type': 'application/json',
        'Cookie': token!,
      });

  if (response.statusCode != 200) {
    return ResponseException.fromJson(
        jsonDecode((utf8.decode(response.bodyBytes))));
  }
  return Character.fromJson(jsonDecode(response.body));
}
