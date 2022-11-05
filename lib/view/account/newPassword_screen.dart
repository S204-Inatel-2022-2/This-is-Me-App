import 'package:flutter/material.dart';
import 'package:this_is_me/components/newPassword_components.dart';
import 'package:this_is_me/constants/app_colors.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: background,
      body:
          Column(mainAxisAlignment: MainAxisAlignment.center, children: const [
        TitleScreen(
          text: 'NOVA SENHA',
        ),
        RobotLogo(),
        PasswordInput(
          textHint: 'SENHA',
        ),
        PasswordInput(
          textHint: 'VERIFICAÇÃO DE SENHA',
        ),
        ConfirmButton()
      ]),
    );
  }
}
