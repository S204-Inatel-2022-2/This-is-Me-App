import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:this_is_me/components/quest_components.dart';
import 'package:this_is_me/constants/app_colors.dart';
import 'package:this_is_me/constants/app_fonts.dart';
import 'package:this_is_me/controller/quest_controller.dart';
import 'package:this_is_me/model/character.dart';
import 'package:this_is_me/model/quest.dart';
import 'package:http/http.dart' as http;
import 'package:this_is_me/view/quest/questCardViewer.dart';

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
                          level: widget.character.level,
                          name: widget.character.characterName,
                          clothes: widget.character.clothes,
                        ),
                        const RightColumn()
                      ],
                    )),
              ])),
          const Positioned(left: 30, bottom: 30, child: NavigationButtons()),
          Positioned(
              left: 34,
              right: 34,
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
                                    style: questContainerTitle,
                                  )),
                              const CreateQuestButton()
                            ]),
                        Expanded(child: QuestViewer())
                      ]),
                    ),
                  ))),
        ]));
  }
}
