import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:this_is_me/components/login_components.dart';
import 'package:this_is_me/constants/app_colors.dart';
import 'package:this_is_me/model/user.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: background,
      body:
          Column(mainAxisAlignment: MainAxisAlignment.center, children: const [
        LoginLogo(imagePath: 'assets/images/loginLogo.png'),
        UserLoginInput(
          emailHint: 'EMAIL',
          passwrdHint: 'PASSWORD',
          forgotPasswordLabel: 'ESQUECI MINHA SENHA',
          newAccountLabel: 'NOVA CONTA',
        ),
        LoginButton(),
        ForgotPasswordButton(message: 'ESQUECI MINHA SENHA'),
        NewAccountButton(message: 'NOVA CONTA')
      ]),
    );
  }
}
