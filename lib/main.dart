import 'package:flutter/material.dart';

import 'package:this_is_me/view/account/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:this_is_me/controller/user_controller.dart';
import 'package:this_is_me/model/character.dart';
import 'package:this_is_me/view/quest/quest_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('token');

  // Verifying if token exists
  if (token == null || token == '') {
    runApp(const MaterialApp(
      home: LoginScreen(),
    ));
  } else {
    runApp(const MaterialApp(
      home: QuestScreen(),
    ));
  }
// Add these 2 lines
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
  //   SystemUiOverlay.bottom, //This line is used for showing the bottom bar
  // ]);
}
