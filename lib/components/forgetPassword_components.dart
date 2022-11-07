import 'package:flutter/material.dart';
import 'package:this_is_me/constants/app_colors.dart';
import 'package:this_is_me/constants/app_fonts.dart';
import 'package:this_is_me/view/account/newPassword_screen.dart';

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
      {super.key, required this.imagePath, required this.description});

  final String imagePath;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.27,
            child: SizedBox(
                width: 300, child: Image.asset('assets/images/robozinho.png')),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Text(
              description,
              style: textForget,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class UserLoginInput extends StatelessWidget {
  const UserLoginInput({super.key, required this.textHint});
  final String textHint;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
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

class SendCodeButton extends StatefulWidget {
  const SendCodeButton({super.key});

  @override
  State<SendCodeButton> createState() => _SendCodeButtonState();
}

class _SendCodeButtonState extends State<SendCodeButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: SizedBox(
          height: 50,
          width: 190,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: midPurple,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: () {},
              child: Text(
                'ENVIAR CÓDIGO',
                style: loginButton,
              ))),
    );
  }
}

class TextDescription extends StatelessWidget {
  const TextDescription({super.key, required this.description});
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 40, bottom: 20),
        child: Expanded(
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  description,
                  style: textForget,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ));
  }
}

class VerifyCodeButton extends StatefulWidget {
  const VerifyCodeButton({super.key});

  @override
  State<VerifyCodeButton> createState() => _VerifyCodeButtonState();
}

class _VerifyCodeButtonState extends State<VerifyCodeButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SizedBox(
          height: 50,
          width: 140,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: midPurple,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NewPasswordScreen())),
              child: Text(
                'VERIFICAR',
                style: loginButton,
              ))),
    );
  }
}

