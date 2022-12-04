import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:this_is_me/model/exception/response_exception.dart';

Future<dynamic> createQuest(http.Client client, body) async {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;
  final String? token = prefs.getString('token');

  final response = await http.post(
      Uri.parse('https://timeapibyredfoxghs.herokuapp.com'
          '/quest'),
      body: jsonEncode({
        "hexColor": body["hexColor"],
        "name": body["name"],
        "desc": body["desc"],
        "startDate": body["startDate"],
        "endDate": body["endDate"],
        "skill": body["skill"],
        "week": body["week"]
      }),
      headers: {
        'Content-Type': 'application/json',
        'Cookie': token!,
      });

  if (response.statusCode != 200) {
    return ResponseException.fromJson(
        jsonDecode((utf8.decode(response.bodyBytes))));
  }
  return response;
}
