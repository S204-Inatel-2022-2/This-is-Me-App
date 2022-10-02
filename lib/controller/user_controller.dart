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

  // TODO: Validar se o código é diferente de 302, se for já retornar erro
  // pode tratar cada erro diferentemente se preferir por exemplo 401
  print("status: " + response.statusCode.toString());
  if (response.statusCode == 401) {
    print("msg: credenciais invalidas");
    //return "";
  } else if (response.statusCode != 302){
    print("msg: erro desconhecido");
    //return "";
  }


  final getCharacterPath = Uri.parse(response.headers['location'].toString());
  final getCharacterToken = response.headers['set-cookie'];


  final character = await client.get(getCharacterPath, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Cookie': '$getCharacterToken',
  });
  

  // Use the compute function to run parsePhotos in a separate isolate.
  return Character.fromJson(jsonDecode(character.body));
}
