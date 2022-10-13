import 'package:blurrycontainer/blurrycontainer.dart';
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
      body: Stack(children: [
        Padding(
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
        Positioned(
            left: 25,
            top: 300,
            bottom: 50,
            child: SizedBox(
                width: 340,
                child: BlurryContainer(
                  color: Colors.grey.withOpacity(0.5),
                  height: 80,
                  child: Column(children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(' Quests do Dia')),
                          Padding(
                              padding: EdgeInsets.only(left: 150),
                              child: FloatingActionButton.small(
                                onPressed: null,
                                backgroundColor: midPurple,
                                child: Icon(Icons.add),
                              ))
                        ])
                  ]),
                )))
      ]),
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
              ),
              SizedBox(
                  width: 200,
                  child: Image.asset('assets/images/personagemFem1.png'))
            ]))
      ],
    );
  }

  Widget rightColumn() {
    return Padding(
        padding: const EdgeInsets.only(bottom: 320),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'Ti-Me',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
                width: 100, child: Image.asset('assets/images/robozinho.png'))
          ],
        ));
  }
}
