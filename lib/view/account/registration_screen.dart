import 'package:flutter/material.dart';
import 'package:this_is_me/components/registration_components.dart';
import 'package:this_is_me/constants/app_colors.dart';


class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: background,
      body: Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Center(
              child: Column(children: const [
            WelcomeWidget(),
            UserNameField(
              hint: 'USERNAME',
            ),
            UserRegistrationInfo(
              emailHint: 'EMAIL',
              passwordHint: 'PASSWORD',
              passwordAgainText: 'PASSWORD AGAIN',
            ),
            RegistrationButton()
          ]))),
    );
  }
}

