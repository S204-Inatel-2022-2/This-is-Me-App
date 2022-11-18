// ignore_for_file: use_build_context_synchronously, unused_import, depend_on_referenced_packages, file_names

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:this_is_me/constants/app_colors.dart';
import 'package:this_is_me/constants/app_fonts.dart';
import 'package:this_is_me/controller/forgetPassword_controller.dart';
import 'package:http/http.dart' as http;
import 'package:this_is_me/view/account/login_screen.dart';
import '../constants/app_texts.dart';

// TextEditingController
TextEditingController passwordController = TextEditingController();
TextEditingController verificationPasswordController = TextEditingController();

class WelcomeNewPassword extends StatelessWidget {
  const WelcomeNewPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
      child: Row(children: [
        Image.asset(
          'assets/images/robozinho.png',
          height: 170,
        ),
        Padding(
            padding: const EdgeInsets.only(left: 20),
            child: SizedBox(
                width: 150,
                child: AutoSizeText(
                  newPasswordText,
                  style: forgotPasswordMessage,
                )))
      ]),
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key, required this.textHint});
  final String textHint;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: textHint,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
              ),
            )),
      ]),
    );
  }
}

class VerifyPasswordInput extends StatelessWidget {
  const VerifyPasswordInput({super.key, required this.textHint});
  final String textHint;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextField(
            controller: verificationPasswordController,
            obscureText: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: textHint,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
              ),
            )),
      ]),
    );
  }
}

class ConfirmButton extends StatefulWidget {
  const ConfirmButton({super.key});

  @override
  State<ConfirmButton> createState() => _ConfirmButtonState();
}

class _ConfirmButtonState extends State<ConfirmButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: SizedBox(
          height: 50,
          width: 150,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: midPurple,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: () async {
                //verifying if the fields arent empty
                if (passwordController.text.isEmpty ||
                    verificationPasswordController.text.isEmpty) {
                  return showDialog<void>(
                    context: context,
                    barrierDismissible: false,
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
                } else {
                  var response = await newPassword(
                      http.Client(),
                      passwordController.text,
                      verificationPasswordController.text);
                  if (response == 200) {
                    Navigator.pushAndRemoveUntil(
                      context, 
                      MaterialPageRoute(builder: (_) => const LoginScreen()), 
                      (route) => false);
                  } else {
                    return showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(response['message']),
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
                }
              },
              child: Text(
                'CONFIRMAR',
                style: loginButton,
              ))),
    );
  }

  void goToLoginScreen() {
    
    print('entrou no goToLoginScreen');
    Navigator.pushNamedAndRemoveUntil(
        context, '/login', (Route<dynamic> route) => false);
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => LoginScreen()));
    // runApp(const MaterialApp(
    //   home: LoginScreen(),
    // ));
  }
}
