import 'package:auto_size_text/auto_size_text.dart';
import 'package:this_is_me/constants/app_colors.dart';
import 'package:this_is_me/constants/app_fonts.dart';
import 'package:this_is_me/constants/app_texts.dart';
import 'package:flutter/material.dart';

// TextEditingController
TextEditingController usernameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController passwordAgainController = TextEditingController();

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
              height: 170,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: SizedBox(
                  width: 200,
                  child: AutoSizeText(
                    welcomeText,
                    style: registrationText,
                    softWrap: true,
                  )),
            )
          ],
        )
      ]),
    );
  }
}

class UserNameField extends StatelessWidget {
  const UserNameField({super.key, required this.hint});
  final String hint;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
      child: SizedBox(
          height: 50,
          child: TextField(
              decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(15),
            hintText: hint,
            filled: true,
            fillColor: inputField,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 3, color: inputField),
              borderRadius: BorderRadius.circular(40),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 3, color: inputField),
              borderRadius: BorderRadius.circular(40),
            ),
          ))),
    );
  }
}

class UserRegistrationInfo extends StatelessWidget {
  const UserRegistrationInfo(
      {super.key,
      required this.emailHint,
      required this.passwordHint,
      required this.passwordAgainText});

  final String emailHint;
  final String passwordHint;
  final String passwordAgainText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'CADASTRO DE AVENTUREIRO NOVATO',
              style: userRegistrationTitle,
            )),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'CRIE SUA CONTA',
              style: userRegistrationSub,
            )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 8),
          child: SizedBox(
              height: 50,
              child: TextField(
                  decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(top: 15, left: 15),
                hintText: emailHint,
                filled: true,
                fillColor: inputField,
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 3, color: inputField),
                  borderRadius: BorderRadius.circular(40),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 3, color: inputField),
                  borderRadius: BorderRadius.circular(40),
                ),
              ))),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 8),
          child: SizedBox(
              height: 50,
              child: TextField(
                  decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(top: 15, left: 15),
                hintText: passwordHint,
                filled: true,
                fillColor: inputField,
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 3, color: inputField),
                  borderRadius: BorderRadius.circular(40),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 3, color: inputField),
                  borderRadius: BorderRadius.circular(40),
                ),
              ))),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 8),
          child: SizedBox(
              height: 50,
              child: TextField(
                  decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(top: 15, left: 15),
                hintText: passwordAgainText,
                filled: true,
                fillColor: inputField,
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 3, color: inputField),
                  borderRadius: BorderRadius.circular(40),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 3, color: inputField),
                  borderRadius: BorderRadius.circular(40),
                ),
              ))),
        )
      ]),
    );
  }
}

class RegistrationButton extends StatelessWidget {
  const RegistrationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 40),
        child: SizedBox(
          height: 50,
          width: 150,
          child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: midPurple,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: Text(
                'CADASTRAR',
                style: registrationButton,
              )),
        ));
  }
}
