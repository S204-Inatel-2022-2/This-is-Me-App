// ignore_for_file: depend_on_referenced_packages, file_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:this_is_me/model/exception/response_exception.dart';

String getEmail = '';

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

  if (response.statusCode != 200) {
    return ResponseException.fromJson(
        jsonDecode((utf8.decode(response.bodyBytes))));
  }
  getEmail = email;
  return response.body;
}

String getTokenNewPassword = '';

Future<dynamic> verifyCode(http.Client client, String email ,int code) async {
  

  if (getEmail == '' && email == '') {
    return ResponseException(
        message: 'Por favor, campo email deve ser preenchido.\n\nobs: caso já tenha um código de verificação valido, não é necessario clicar no botão "enviar código" novamente.'); 
  }

  email = email == '' ? getEmail : email;
  
  final response = await client.post(
      Uri.parse('https://timeapibyredfoxghs.herokuapp.com'
          '/user/reset/verify-code-reset'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{'email': email, 'number': code}));

  if (response.statusCode != 200) {
    return ResponseException.fromJson(
        jsonDecode((utf8.decode(response.bodyBytes))));
  }

  getTokenNewPassword = response.headers['set-cookie']!;
  return response.statusCode;
}

Future<dynamic> newPassword(
  http.Client client,
  String password,
  String verifyPassword,
) async {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;

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

  prefs.setString('token', '');

  return response.statusCode;
}
