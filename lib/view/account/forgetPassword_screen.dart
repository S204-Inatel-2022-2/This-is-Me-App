import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:this_is_me/components/forgetPassword_components.dart';
import 'package:this_is_me/constants/app_colors.dart';
import 'package:this_is_me/constants/app_fonts.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: background,
      body: Center(
          child: Padding(
              padding: const EdgeInsets.only(top: 70),
              child: Column(children: [
                Text(
                  'ESQUECI A SENHA',
                  style: forgetTitle,
                ),
                const WelcomeForgotPassword(),
                const ForgotEmailInput(
                  emailHint: 'EMAIL',
                ),
                CodeVerificationInput(
                    codeVerificationHint: 'CÓDIGO DE VERIFICAÇÃO')
              ]))),
    );
  }
}
