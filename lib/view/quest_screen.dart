import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:this_is_me/constants/app_colors.dart';
import 'package:this_is_me/constants/app_fonts.dart';
import 'package:this_is_me/model/character.dart';

class QuestScreen extends StatefulWidget {
  const QuestScreen({super.key, required this.character});
  final Character character;
  @override
  State<QuestScreen> createState() => _QuestScreenState();
}

class _QuestScreenState extends State<QuestScreen> {
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
                    )),
                Padding(
                    padding:
                        const EdgeInsets.only(top: 70, left: 25, right: 25),
                    child: Row(children: const [
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: FloatingActionButton(
                            onPressed: null,
                            backgroundColor: midPurple,
                          )),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: FloatingActionButton(
                            onPressed: null,
                            backgroundColor: midPurple,
                          )),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: FloatingActionButton(
                            onPressed: null,
                            backgroundColor: midPurple,
                          )),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: FloatingActionButton(
                            onPressed: null,
                            backgroundColor: midPurple,
                          )),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: FloatingActionButton(
                            onPressed: null,
                            backgroundColor: midPurple,
                          )),
                    ]))
              ])),
          Positioned(
              left: 25,
              top: 300,
              bottom: 50,
              child: Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: SizedBox(
                    width: 340,
                    child: BlurryContainer(
                      color: Colors.grey.withOpacity(0.5),
                      child: Column(children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    ' Quests do Dia',
                                    style: questTitle,
                                  )),
                              const Padding(
                                  padding: EdgeInsets.only(left: 120),
                                  child: FloatingActionButton.small(
                                    onPressed: null,
                                    backgroundColor: midPurple,
                                    child: Icon(Icons.add),
                                  ))
                            ]),
                        // FutureBuilder<List<Quest>>()
                      ]),
                    ),
                  ))),
        ]));
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
