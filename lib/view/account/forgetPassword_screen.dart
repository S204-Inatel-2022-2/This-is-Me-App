import 'package:flutter/material.dart';
import 'package:this_is_me/components/forgetPassword_components.dart';
import 'package:this_is_me/constants/app_colors.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: background,
      body:
          Column(mainAxisAlignment: MainAxisAlignment.center, children: const [
        TitleScreen(
          text: 'ESQUECI A SENHA',
        ),
        RobotLogo(
          imagePath: 'assets/images/robozinho.png',
          description:
              'Digite seu email abaixo, enviarei um código de verificação para realizar a troca de senha.',
        ),
        UserLoginInput(
          textHint: 'EMAIL',
        ),
        SendCodeButton(),
        TextDescription(
          description: 'INSIRA O CÓDIGO RECEBIDO NO CAMPO ABAIXO',
        ),
        UserLoginInput(
          textHint: 'CÓDIGO DE VERIFICAÇÃO',
        ),
        VerifyCodeButton()
      ]),
    );
  }
}
