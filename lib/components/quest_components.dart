import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:this_is_me/constants/app_colors.dart';
import 'package:this_is_me/constants/app_fonts.dart';
import 'package:this_is_me/controller/quest_controller.dart';
import 'package:this_is_me/model/quest.dart';
import 'package:http/http.dart' as http;

class QuestList extends StatelessWidget {
  const QuestList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Quest>>(
      future: getTodayQuests(http.Client()),
      builder: ((context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error!.toString()),
          );
        } else if (snapshot.hasData) {
          return QuestLoader(quests: snapshot.data!);
        }
        return const Center(child: CircularProgressIndicator());
      }),
    );
  }
}

class QuestLoader extends StatefulWidget {
  const QuestLoader({super.key, required this.quests});

  final List<Quest> quests;

  @override
  State<QuestLoader> createState() => _QuestLoaderState();
}

class _QuestLoaderState extends State<QuestLoader> {
  late bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: widget.quests.length,
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Container(
              decoration: BoxDecoration(
                  color: Color(int.parse(widget.quests[index].color)),
                  borderRadius: const BorderRadius.all(Radius.circular(15))),
              child: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  isThreeLine: true,
                  title: Text(
                    widget.quests[index].name,
                    style: GoogleFonts.jura(
                        color: Color(int.parse(widget.quests[index].color))
                                    .computeLuminance() >
                                0.5
                            ? Colors.black
                            : Colors.white),
                  ),
                  subtitle: Text(
                      'Skill: ${widget.quests[index].skill}\nHora: ${widget.quests[index].startTime} - ${widget.quests[index].endTime} ',
                      style: GoogleFonts.jura(
                          color: Color(int.parse(widget.quests[index].color))
                                      .computeLuminance() >
                                  0.5
                              ? Colors.black
                              : Colors.white)),
                  secondary: Column(
                    children: [
                      Text(
                          '${widget.quests[index].finalized}/${widget.quests[index].total}',
                          style: GoogleFonts.jura(
                              color:
                                  Color(int.parse(widget.quests[index].color))
                                              .computeLuminance() >
                                          0.5
                                      ? Colors.black
                                      : Colors.white)),
                      Text(widget.quests[index].duration,
                          style: GoogleFonts.jura(
                              color:
                                  Color(int.parse(widget.quests[index].color))
                                              .computeLuminance() >
                                          0.5
                                      ? Colors.black
                                      : Colors.white)),
                      Text('${widget.quests[index].xp}XP',
                          style: GoogleFonts.jura(
                              color:
                                  Color(int.parse(widget.quests[index].color))
                                              .computeLuminance() >
                                          0.5
                                      ? Colors.black
                                      : Colors.white))
                    ],
                  ),
                  onChanged: (bool? value) {
                    setState(() {
                      isSelected = value!;
                    });
                  },
                  value: isSelected),
            ));
      },
    );
  }
}

class LeftColumn extends StatelessWidget {
  const LeftColumn({
    super.key,
    required this.level,
    required this.name,
    required this.clothes
  });
  final String level;
  final String name;
  final int clothes;
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
                  child: Image.asset(getClothesDir(clothes)))
            ]))
      ],
    );
  }

  String getClothesDir(int number){
    if(number == 1)
      return 'assets/images/personagemFem1.png';

    return 'assets/images/personagemMasc1.png';
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
    return Row(children: [
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
    ]);
  }
}
