import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:this_is_me/controller/user_controller.dart';
import 'package:this_is_me/model/character.dart';
import 'package:this_is_me/view/account/login_screen.dart';
import 'package:this_is_me/view/quest_screen.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> _token;
  late Future<String> _route;

  @override
  void initState() {
    super.initState();
    _token = _prefs.then((SharedPreferences prefs) {
      return prefs.getString('token').toString();
    });
    _route = _prefs.then((SharedPreferences prefs) {
      return prefs.getString('route').toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
        future: Future.wait([
          _token,
          _route,
        ]),
        builder: (BuildContext context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.data!.first == 'null' ||
                  snapshot.data!.last == 'null') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              } else {
   
                return FutureBuilder(
                  future: loadCharacter(
                      http.Client(), snapshot.data!.first, snapshot.data!.last),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var character = Character.fromJson(
                          jsonDecode(snapshot.data!.toString()));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuestScreen(
                                    character: character,
                                  )));
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                );
              }
              return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
