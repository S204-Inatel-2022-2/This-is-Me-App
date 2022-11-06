// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:this_is_me/components/newPassword_components.dart';
import 'package:this_is_me/constants/app_colors.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: background,
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Center(
                  child: Column(children: const [
                    TitleScreen(
                      text: 'NOVA SENHA',
                    ),
                    RobotLogo(),
                    PasswordInput(
                      textHint: 'SENHA',
                    ),
                    VerifyPasswordInput(
                      textHint: 'VERIFICAÇÃO DE SENHA',
                    ),
                    ConfirmButton()
                  ]),
                ))));
  }
}
