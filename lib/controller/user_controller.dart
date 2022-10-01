import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:this_is_me/model/user.dart';
import 'package:http/http.dart' as http;

Future<http.Response> loginUser(
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

  return response;
}

// A function that converts a response body into a List<Photo>.
User parseLists(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<User>((json) => User.fromJson(json));
}
