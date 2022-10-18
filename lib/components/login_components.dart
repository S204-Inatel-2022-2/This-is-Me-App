import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:this_is_me/constants/app_colors.dart';
import 'package:this_is_me/constants/app_fonts.dart';
import 'package:this_is_me/controller/user_controller.dart';
import 'package:this_is_me/model/character.dart';
import 'package:this_is_me/view/account/forgetPassword_screen.dart';
import 'package:this_is_me/view/quest_screen.dart';
import 'package:this_is_me/view/account/registration_screen.dart';
import 'package:http/http.dart' as http;
import 'package:this_is_me/view/account/registration_screen.dart';

// TextEditingController
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class LoginLogo extends StatelessWidget {
  const LoginLogo({super.key, required this.imagePath});

  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Image.asset(
              imagePath,
            )));
  }
}

class UserLoginInput extends StatelessWidget {
  const UserLoginInput(
      {super.key,
      required this.emailHint,
      required this.passwrdHint,
      required this.forgotPasswordLabel,
      required this.newAccountLabel});

  final String emailHint;
  final String passwrdHint;
  final String forgotPasswordLabel;
  final String newAccountLabel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: inputField,
                  hintText: emailHint,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 3, color: inputField),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 3, color: inputField),
                    borderRadius: BorderRadius.circular(40),
                  ),
                ))),
        Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: inputField,
                  hintText: passwrdHint,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ))),
      ]),
    );
  }
}

class LoginButton extends StatefulWidget {
  const LoginButton({super.key});

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> _token;
  Future<void> _incrementCounter() async {
    final SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString('token');

    setState(() {
      _token = prefs.setString('token', token!).then((bool success) {
        return _token;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: SizedBox(
          height: 50,
          width: 150,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: midPurple,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: () async {
                if (emailController.text.isEmpty ||
                    passwordController.text.isEmpty) {
                  return showDialog<void>(
                    context: context,
                    barrierDismissible: false, // user must tap button!
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Preencha os campos corretamente'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Ok'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }

                var character = await loginUser(http.Client(),
                    emailController.text, passwordController.text);
                if (character is! Character) {
                  return showDialog<void>(
                    context: context,
                    barrierDismissible: false, // user must tap button!
                    builder: (BuildContext context) {
                      if (character == 'Bad credentials') {
                        character = 'Usuário inexistente ou senha inválida';
                      }
                      return AlertDialog(
                        title: Text(character.toString()),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Ok'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }

                goToCharacterScreen(character);
              },
              child: Text(
                'LOGIN',
                style: loginButton,
              ))),
    );
  }

  void goToCharacterScreen(Character character) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => QuestScreen(
                  character: character,
                )));
  }
}

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: TextButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ForgetPasswordScreen())),
          child: Text(
            message,
            style: forgotPasswordButton,
          )),
    );
  }
}

class NewAccountButton extends StatelessWidget {
  const NewAccountButton({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: TextButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const RegistrationScreen())),
          child: Text(
            message,
            style: newAccountButton,
          )),
    );
  }
}
