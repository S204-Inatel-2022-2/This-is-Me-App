// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, file_names

import 'package:auto_size_text/auto_size_text.dart';
import 'package:this_is_me/constants/app_colors.dart';
import 'package:this_is_me/constants/app_fonts.dart';
import 'package:this_is_me/constants/app_texts.dart';
import 'package:flutter/material.dart';
import 'package:this_is_me/controller/forgetPassword_controller.dart';
import 'package:http/http.dart' as http;
import 'package:this_is_me/model/exception/response_exception.dart';
import 'package:this_is_me/view/account/newPassword_screen.dart';

// TextEditingController
TextEditingController emailController = TextEditingController();
TextEditingController verificationCodeController = TextEditingController();

class WelcomeForgotPassword extends StatelessWidget {
  const WelcomeForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
      child: Row(children: [
        Image.asset(
          'assets/images/robozinho.png',
          height: 170,
        ),
        Padding(
            padding: const EdgeInsets.only(left: 20),
            child: SizedBox(
                width: 150,
                child: AutoSizeText(
                  forgetPasswordText,
                  style: forgotPasswordMessage,
                )))
      ]),
    );
  }
}

class ForgotEmailInput extends StatelessWidget {
  const ForgotEmailInput({
    super.key,
    required this.emailHint,
  });

  final String emailHint;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 8),
        child: SizedBox(
            height: 50,
            child: TextField(
                controller: emailController,
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
      const SendCodeButton()
    ]);
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
        padding: const EdgeInsets.only(top: 20),
        child: SizedBox(
          height: 50,
          width: 180,
          child: ElevatedButton(
              onPressed: () async {
                //verifying if the fields arent empty
                if (emailController.text.isEmpty) {
                  return showDialog<void>(
                    context: context,
                    barrierDismissible: false, // user must tap button!
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Preencha os campos corretamente!'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Ok'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }else {
                  var response =
                      await sendCode(http.Client(), emailController.text);
                  if (response is String) {
                    return showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(response),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Ok'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }else if (response is ResponseException) {
                    return showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('${response.message}'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Ok'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: midPurple,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: Text(
                'ENVIAR CÓDIGO',
                style: registrationButton,
              )),
        ));
  }
}

class CodeVerificationInput extends StatelessWidget {
  const CodeVerificationInput({
    super.key,
    required this.codeVerificationHint,
  });

  final String codeVerificationHint;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Text(
              'INSIRA O CÓDIGO RECEBIDO NO CAMPO ABAIXO',
              style: textCodeForget,
            )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 8),
          child: SizedBox(
              height: 50,
              child: TextField(
                  controller: verificationCodeController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(top: 15, left: 15),
                    hintText: codeVerificationHint,
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
        const CodeVerifyButton()
      ],
    );
  }
}

class CodeVerifyButton extends StatefulWidget {
  const CodeVerifyButton({super.key});

  @override
  State<CodeVerifyButton> createState() => _CodeVerifyButtonState();
}

class _CodeVerifyButtonState extends State<CodeVerifyButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: SizedBox(
          height: 50,
          width: 180,
          child: ElevatedButton(
              onPressed: () async {
                //verifying if the fields arent empty
                if (verificationCodeController.text.isEmpty) {
                  return showDialog<void>(
                    context: context,
                    barrierDismissible: false, // user must tap button!
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Preencha os campos corretamente'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Ok'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  var verifyCodeRequest = await verifyCode(
                      http.Client(),
                      int.parse(verificationCodeController.text));
                  if (verifyCodeRequest) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NewPasswordScreen()));
                  } else {
                    verificationCodeController.clear();
                    showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Token inválido'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Ok'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: midPurple,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: Text(
                'ENVIAR CÓDIGO',
                style: registrationButton,
              )),
        ));
  }
}

