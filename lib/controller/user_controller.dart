import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:this_is_me/model/character.dart';
import 'package:this_is_me/model/user.dart';
import 'package:http/http.dart' as http;

Future<Character> loginUser(
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

  final getCharacterUrl = Uri.parse(response.headers['location'].toString());
  final getCharacterToken = response.headers['set-cookie'];
  final character = await client.get(getCharacterUrl, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    // 'Authorization': 'Bearer $getCharacterToken',
  });

  print('Headers: ${response.headers}');
  // print('Rota: $getCharacterUrl');
  // print('Token: $getCharacterToken}');
  // print('Status: ${character.statusCode}');
  // print('Corpo: ${character.body}');
  // Use the compute function to run parsePhotos in a separate isolate.
  return Character.fromJson(jsonDecode(character.body));
}
