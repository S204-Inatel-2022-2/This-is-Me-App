import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:this_is_me/constants/app_colors.dart';
import 'package:this_is_me/constants/app_fonts.dart';
import 'package:this_is_me/model/character.dart';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({super.key, required this.character});
  final Character character;
  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: background,
      body: Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Column(children: [
            Center(
                child: Text(
              'Quadros',
              style: screenTitle,
            )),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [leftColumn(), rightColumn()],
                ))
          ])),
    );
  }

  Widget leftColumn() {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Column(children: [
              Text(
                'Nv.${widget.character.level}',
                style: characterLevel,
              ),
              Text(
                widget.character.characterName,
                style: characterName,
              ), SizedBox(
                
                width: 200,
                child:Image.asset('assets/images/personagemFem1.png'))
            ]))
      ],
    );
  }

  Widget rightColumn() {
    return Column();
  }
}
