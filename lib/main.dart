import 'package:flutter/material.dart';
import 'package:this_is_me/view/account/login_screen.dart';
import 'package:this_is_me/view/home.dart';

void main() {
// Add these 2 lines
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
  //   SystemUiOverlay.bottom, //This line is used for showing the bottom bar
  // ]);
  runApp(const MaterialApp(home: LoginScreen()));
}
