import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:this_is_me/controller/quest_controller.dart';
import 'package:this_is_me/model/quest.dart';
import 'package:http/http.dart' as http;

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
            return QuestLoader(quests: snapshot.data!);
          }
          return const Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }
}

class QuestLoader extends StatefulWidget {
  QuestLoader({super.key, required this.quests});

  final List<Quest> quests;

  @override
  State<QuestLoader> createState() => _QuestLoaderState();
}

class _QuestLoaderState extends State<QuestLoader> {
  late bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.quests.length,
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Container(
              decoration: BoxDecoration(
                  color: Color(int.parse(widget.quests[index].color)),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
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
                  // secondary: Column(
                  //   children: [Text('1'), Text('2'), Text('3')],
                  // ),
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
