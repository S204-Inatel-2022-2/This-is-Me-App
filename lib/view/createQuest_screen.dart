// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:this_is_me/components/createQuest_components.dart';
import 'package:this_is_me/constants/app_colors.dart';
import 'package:this_is_me/constants/app_fonts.dart';
import 'package:this_is_me/constants/app_texts.dart';

class CreateQuestScreen extends StatefulWidget {
  const CreateQuestScreen({Key? key}) : super(key: key);

  @override
  _CreateQuestScreenState createState() => _CreateQuestScreenState();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class _CreateQuestScreenState extends State<CreateQuestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SingleChildScrollView(
          child: Column(children: [
        Row(children: [
          const BackToQuestButton(),
          Padding(
              padding: const EdgeInsets.only(top: 50, left: 20),
              child: Row(children: [
                Text(
                  'NOVA QUEST',
                  style: createNewQuestTitle,
                ),
                const CreateTaskButton()
              ])),
        ]),
        const NameInput(
          textHint: "NOME DA TASK",
        ),
        const DescriptionInput(
          textHint: "BREVE DESCRIÇÂO...",
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(skillDescriptionText, style: createSkillsDescription)),
        const ButtonCreateSkills(),
        const DaysInWeekComponents(
            textCheckBoxEveryDay: createQuestRepeatDays,
            textCheckBoxSameHour: createQuestSameHour)
      ])),
    );
  }
}
