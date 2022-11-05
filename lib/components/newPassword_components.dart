import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:this_is_me/constants/app_colors.dart';
import 'package:this_is_me/constants/app_fonts.dart';

import '../constants/app_texts.dart';

class TitleScreen extends StatelessWidget {
  const TitleScreen({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Expanded(
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Text(
              text,
              style: screenTitle,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ));
  }
}

class RobotLogo extends StatelessWidget {
  const RobotLogo(
      {super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
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
                  newPasswordText,
                  style: registrationText,
                  softWrap: true,
                )),
          )
        ],
      ),
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
              onPressed: () {},
              child: Text(
                'CONFIRMAR',
                style: loginButton,
              ))),
    );
  }
}
