import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:this_is_me/components/quest_components.dart';
import 'package:this_is_me/constants/app_colors.dart';
import 'package:this_is_me/constants/app_fonts.dart';
import 'package:this_is_me/controller/character_controller.dart';
import 'package:this_is_me/controller/quest_controller.dart';
import 'package:this_is_me/model/character.dart';
import 'package:this_is_me/model/quest.dart';
import 'package:http/http.dart' as http;
import 'package:this_is_me/view/quest/questCardViewer.dart';

class QuestScreen extends StatefulWidget {
  const QuestScreen({super.key});

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
                        FutureBuilder(
                            future: getCharacter(http.Client()),
                            builder: (((context, snapshot) {
                              if (snapshot.hasError) {
                                return Center(
                                    child: Text(snapshot.error.toString()));
                              }
                              if (snapshot.hasData &&
                                  snapshot.data is Character) {
                                Character character =
                                    snapshot.data as Character;

                                return LeftColumn(
                                  level: character.level.toString(),
                                  name: character.characterName,
                                  clothes: character.clothes,
                                );
                              }
                              return SizedBox(
                                width: 150,
                                child: LoadingAnimationWidget.halfTriangleDot(
                                    size: 40, color: Colors.white),
                              );
                            }))),
                        const RightColumn()
                      ],
                    )),
              ])),
          QuestCardViewer(),
          const Positioned(left: 30, bottom: 30, child: NavigationButtons()),
        ]));
  }
}
