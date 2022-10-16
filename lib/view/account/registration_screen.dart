import 'package:flutter/material.dart';
import 'package:this_is_me/constants/app_colors.dart';
import 'package:this_is_me/constants/app_fonts.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Center(child: Column(children: const [WelcomeWidget()]))),
    );
  }
}

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(children: [
        Text('BEM VINDO!!!', style: registrationTitle),
        Row(
          children: [
            Image.asset(
              'assets/images/robozinho.png',
              height: 180,
            )
          ],
        )
      ]),
    );
  }
}
