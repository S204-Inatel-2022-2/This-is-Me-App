import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:this_is_me/model/character.dart';
import 'package:http/http.dart' as http;
import 'package:this_is_me/model/quest.dart';

Future<List<Quest>> getTodayQuests(http.Client client) async {
  final prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('token');
  final response = await client.get(
      Uri.parse(
          'https://timeapibyredfoxghs.herokuapp.com/subQuest/today-cards'),
      headers: {'accept': 'application/json', 'Cookie': token.toString()});

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseQuests, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Quest> parseQuests(String responseBody) {
  final parsed = jsonDecode(utf8.decode((responseBody.codeUnits)))
      .cast<Map<String, dynamic>>();

  print(responseBody);
  return parsed.map<Quest>((json) => Quest.fromJson(json)).toList();
}
