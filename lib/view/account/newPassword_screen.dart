// ignore_for_file: unused_import, file_names

import 'package:flutter/material.dart';
import 'package:this_is_me/components/newPassword_components.dart';
import 'package:this_is_me/constants/app_colors.dart';
import 'package:this_is_me/constants/app_fonts.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: background,
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(top: 80),
          child: Column(children: [
            Text(
              'ESQUECI A SENHA',
              style: screenTitle,
            ),
            const WelcomeNewPassword(),
            const PasswordInput(
              textHint: 'SENHA',
            ),
            const VerifyPasswordInput(
              textHint: 'VERIFICAÇÃO DE SENHA',
            ),
            const ConfirmButton()
          ]),
        )));
  }
}
