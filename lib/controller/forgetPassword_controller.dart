// ignore_for_file: depend_on_referenced_packages, file_names

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<dynamic> sendCode(
  http.Client client,
  String email,
) async {
  final response = await client.post(
      Uri.parse('https://timeapibyredfoxghs.herokuapp.com'
          '/user/reset/forgot-password?email=${email}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });
  return response.body;
}

String getTokenNewPassword = '';

Future<dynamic> verifyCode(http.Client client, String email, int code) async {
  final response = await client.post(
      Uri.parse('https://timeapibyredfoxghs.herokuapp.com'
          '/user/reset/verify-code-reset'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{'email': email, 'number': code}));
  if (response.statusCode == 200) {
    getTokenNewPassword = response.headers['set-cookie']!;
    return true;
  }
  return false;
}

Future<dynamic> newPassword(
  http.Client client,
  String password,
  String verifyPassword,
) async {
  final response = await client.post(
      Uri.parse('https://timeapibyredfoxghs.herokuapp.com'
          '/user/reset/reset-password'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Cookie': getTokenNewPassword
      },
      body: jsonEncode(<String, dynamic>{
        'password': password,
        'passwordVerify': verifyPassword
      }));

  if (response.statusCode != 200) {
    return jsonDecode((utf8.decode(response.bodyBytes)));
  }

  return response.statusCode;
}
