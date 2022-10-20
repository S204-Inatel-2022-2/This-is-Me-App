import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:this_is_me/constants/app_colors.dart';
import 'package:this_is_me/constants/app_fonts.dart';
import 'package:this_is_me/controller/quest_controller.dart';
import 'package:this_is_me/model/character.dart';
import 'package:this_is_me/model/quest.dart';
import 'package:http/http.dart' as http;

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
              padding: const EdgeInsets.only(top: 25),
              child: Column(children: [
                Center(
                    child: Text(
                  'Quadros',
                  style: screenTitle,
                )),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        LeftColumn(
                          level: widget.character.level.toString(),
                          name: widget.character.characterName,
                        ),
                        const RightColumn()
                      ],
                    )),
                const NavigationButtons()
              ])),
          Positioned(
              left: 25,
              top: 270,
              bottom: 50,
              child: Padding(
                  padding: const EdgeInsets.only(bottom: 70),
                  child: SizedBox(
                    width: 340,
                    child: BlurryContainer(
                      color: Colors.grey.withOpacity(0.5),
                      child: Column(children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Text(
                                    'Quests do Dia',
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
                        QuestList()
                      ]),
                    ),
                  ))),
        ]));
  }
}

class LeftColumn extends StatelessWidget {
  const LeftColumn({
    super.key,
    required this.level,
    required this.name,
  });
  final String level;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Column(children: [
              Text(
                'Nv.$level',
                style: characterLevel,
              ),
              Text(
                name,
                style: characterName,
              ),
              SizedBox(
                  width: 200,
                  child: Image.asset('assets/images/personagemFem1.png'))
            ]))
      ],
    );
  }
}

class RightColumn extends StatelessWidget {
  const RightColumn({super.key});

  @override
  Widget build(BuildContext context) {
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
    ;
  }
}

class NavigationButtons extends StatelessWidget {
  const NavigationButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            const EdgeInsets.only(top: 70, left: 25, right: 25, bottom: 20),
        child: Row(children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Column(children: [
                FloatingActionButton(
                  heroTag: 'skill_button',
                  onPressed: null,
                  backgroundColor: midPurple,
                  child: Image.asset('assets/images/icons/skill_icon.png'),
                ),
                Text('Skill', style: navigationButtonsLabels)
              ])),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Column(children: [
                FloatingActionButton(
                  heroTag: 'agenda_button',
                  onPressed: null,
                  backgroundColor: midPurple,
                  child: Image.asset('assets/images/icons/agenda_icon.png'),
                ),
                Text('Agenda', style: navigationButtonsLabels)
              ])),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Column(children: [
                FloatingActionButton(
                  heroTag: 'amigos_button',
                  onPressed: null,
                  backgroundColor: midPurple,
                  child: Image.asset('assets/images/icons/amigos_icon.png'),
                ),
                Text('Amigos', style: navigationButtonsLabels)
              ])),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Column(children: [
                FloatingActionButton(
                  heroTag: 'ranks_button',
                  onPressed: null,
                  backgroundColor: midPurple,
                  child: Image.asset('assets/images/icons/ranks_icon.png'),
                ),
                Text('Ranks', style: navigationButtonsLabels)
              ])),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Column(children: [
                FloatingActionButton(
                  heroTag: 'perfil_button',
                  onPressed: null,
                  backgroundColor: midPurple,
                  child: Image.asset('assets/images/icons/perfil_icon.png'),
                ),
                Text('Perfil', style: navigationButtonsLabels)
              ])),
        ]));
  }
}

class QuestList extends StatelessWidget {
  const QuestList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<Quest>>(
        future: getTodayQuests(http.Client()),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error!.toString()),
            );
          } else if (snapshot.hasData) {
            return Center(
              child: Text(snapshot.data!.toString()),
            );
          }
          return const Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }
}
