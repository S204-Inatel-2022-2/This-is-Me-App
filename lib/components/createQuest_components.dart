// ignore_for_file: no_leading_underscores_for_local_identifiers, no_logic_in_create_state, library_private_types_in_public_api, prefer_typing_uninitialized_variables, use_build_context_synchronously, depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:this_is_me/constants/app_colors.dart';
import 'package:this_is_me/constants/app_fonts.dart';
import 'package:this_is_me/controller/createQuest_controller.dart';
import 'package:http/http.dart' as http;
import 'package:this_is_me/controller/user_controller.dart';
import 'package:this_is_me/model/character.dart';
import 'package:this_is_me/view/quest/quest_screen.dart';

TextEditingController nameController = TextEditingController();
TextEditingController descriptionController = TextEditingController();
TextEditingController skillController = TextEditingController();
TextEditingController startDate = TextEditingController();
TextEditingController endDate = TextEditingController();
TextEditingController segStart = TextEditingController();
TextEditingController segEnd = TextEditingController();
TextEditingController terStart = TextEditingController();
TextEditingController terEnd = TextEditingController();
TextEditingController quaStart = TextEditingController();
TextEditingController quaEnd = TextEditingController();
TextEditingController quiStart = TextEditingController();
TextEditingController quiEnd = TextEditingController();
TextEditingController sexStart = TextEditingController();
TextEditingController sexEnd = TextEditingController();
TextEditingController sabStart = TextEditingController();
TextEditingController sabEnd = TextEditingController();
TextEditingController domStart = TextEditingController();
TextEditingController domEnd = TextEditingController();
TextEditingController sameHourStart = TextEditingController();
TextEditingController sameHourEnd = TextEditingController();

Color selectedColor = Colors.red;
bool checkBoxIsEnabledEveryDay = false;
bool checkBoxIsEnabledSameHour = false;

List weekDays = [
  {"enabled": false, "name": "SEGUNDA", "initials": "Seg"},
  {"enabled": false, "name": "TERÇA", "initials": "Ter"},
  {"enabled": false, "name": "QUARTA", "initials": "Qua"},
  {"enabled": false, "name": "QUINTA", "initials": "Qui"},
  {"enabled": false, "name": "SEXTA", "initials": "Sex"},
  {"enabled": false, "name": "SABADO", "initials": "Sab"},
  {"enabled": false, "name": "DOMINGO", "initials": "Dom"}
];

class BackToQuestButton extends StatelessWidget {
  const BackToQuestButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 50),
      child: FloatingActionButton(
        onPressed: () => Navigator.of(context).pop(),
        backgroundColor: background,
        child: Image.asset(
          'assets/images/icons/Vector.png',
          width: 50,
        ),
      ),
    );
  }
}

class CreateTaskButton extends StatelessWidget {
  const CreateTaskButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 15),
        child: SizedBox(
          height: 50,
          width: 130,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: midPurple,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            onPressed: () async {
              var colorHexa = selectedColor;

              var bodyRequest = {
                "name": nameController.text,
                "desc": descriptionController.text,
                "startDate": startDate.text,
                "endDate": endDate.text,
                "hexColor":
                    "0xff${colorHexa.red.toRadixString(16)}${colorHexa.green.toRadixString(16)}${colorHexa.blue.toRadixString(16)}",
                "skill": {"name": skillController.text},
                "week": [
                  for (Object i in [
                    if ((weekDays[0]["enabled"] &&
                            segStart.text != "" &&
                            segEnd.text != "") ||
                        checkBoxIsEnabledSameHour)
                      {
                        "startTime": checkBoxIsEnabledSameHour
                            ? sameHourStart.text
                            : segStart.text,
                        "endTime": checkBoxIsEnabledSameHour
                            ? sameHourEnd.text
                            : segEnd.text,
                        "dayOfWeekCustom": "MONDAY"
                      },
                    if ((weekDays[1]["enabled"] &&
                            terStart.text != "" &&
                            terEnd.text != "") ||
                        checkBoxIsEnabledSameHour)
                      {
                        "startTime": checkBoxIsEnabledSameHour
                            ? sameHourStart.text
                            : terStart.text,
                        "endTime": checkBoxIsEnabledSameHour
                            ? sameHourEnd.text
                            : terEnd.text,
                        "dayOfWeekCustom": "TUESDAY"
                      },
                    if ((weekDays[2]["enabled"] &&
                            quaStart.text != "" &&
                            quaStart.text != "") ||
                        checkBoxIsEnabledSameHour)
                      {
                        "startTime": checkBoxIsEnabledSameHour
                            ? sameHourStart.text
                            : quaStart.text,
                        "endTime": checkBoxIsEnabledSameHour
                            ? sameHourEnd.text
                            : quaEnd.text,
                        "dayOfWeekCustom": "WEDNESDAY"
                      },
                    if ((weekDays[3]["enabled"] &&
                            quiStart.text != "" &&
                            quiEnd.text != "") ||
                        checkBoxIsEnabledSameHour)
                      {
                        "startTime": checkBoxIsEnabledSameHour
                            ? sameHourStart.text
                            : quiStart.text,
                        "endTime": checkBoxIsEnabledSameHour
                            ? sameHourEnd.text
                            : quiEnd.text,
                        "dayOfWeekCustom": "THURSDAY"
                      },
                    if ((weekDays[4]["enabled"] &&
                            sexStart.text != "" &&
                            sexEnd.text != "") ||
                        checkBoxIsEnabledSameHour)
                      {
                        "startTime": checkBoxIsEnabledSameHour
                            ? sameHourStart.text
                            : sexStart.text,
                        "endTime": checkBoxIsEnabledSameHour
                            ? sameHourEnd.text
                            : sexEnd.text,
                        "dayOfWeekCustom": "FRIDAY"
                      },
                    if ((weekDays[5]["enabled"] &&
                            sabStart.text != "" &&
                            sabEnd.text != "") ||
                        checkBoxIsEnabledSameHour)
                      {
                        "startTime": checkBoxIsEnabledSameHour
                            ? sameHourStart.text
                            : sabStart.text,
                        "endTime": checkBoxIsEnabledSameHour
                            ? sameHourEnd.text
                            : sabEnd.text,
                        "dayOfWeekCustom": "SATURDAY"
                      },
                    if ((weekDays[6]["enabled"] &&
                            domStart.text != "" &&
                            domEnd.text != "") ||
                        checkBoxIsEnabledSameHour)
                      {
                        "startTime": checkBoxIsEnabledSameHour
                            ? sameHourStart.text
                            : domStart.text,
                        "endTime": checkBoxIsEnabledSameHour
                            ? sameHourEnd.text
                            : domEnd.text,
                        "dayOfWeekCustom": "SUNDAY"
                      },
                  ])
                    i
                ]
              };

              var request = await createQuest(http.Client(), bodyRequest);
              if (request is http.Response && request.statusCode == 200) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const QuestScreen()),
                    (route) => false);
              } else {
                return showDialog<void>(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(request.message),
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
            },
            child: Text('Criar', style: createButtonCreate),
          ),
        ));
  }
}

class NameInput extends StatelessWidget {
  const NameInput({super.key, required this.textHint});
  final String textHint;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 20),
        child: Row(
          children: [
            SizedBox(
                width: 300,
                child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: textHint,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ))),
            const Padding(
                padding: EdgeInsets.only(left: 10), child: ColorComponent())
          ],
        ));
  }
}

class ColorComponent extends StatefulWidget {
  const ColorComponent({Key? key}) : super(key: key);

  @override
  _ColorComponentState createState() => _ColorComponentState();
}

class _ColorComponentState extends State<ColorComponent> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 50,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: selectedColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50))),
          onPressed: () => showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                    title: const Text('Selecione uma cor: '),
                    content: MaterialColorPicker(
                      onColorChange: (Color color) {
                        setState(() {
                          selectedColor = color;
                        });
                      },
                      selectedColor: selectedColor,
                      colors: const [
                        Colors.red,
                        Colors.green,
                        Colors.purple,
                        Colors.blue,
                        Colors.yellow
                      ],
                    ),
                    actions: [
                      TextButton(
                        child: const Text('Ok'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  )),
          child: null,
        ));
  }
}

class DescriptionInput extends StatelessWidget {
  const DescriptionInput({super.key, required this.textHint});
  final String textHint;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: TextFormField(
          controller: descriptionController,
          minLines: 2,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: textHint,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          )),
    );
  }
}

class SkillInput extends StatelessWidget {
  const SkillInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
      child: TextFormField(
          controller: skillController,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          decoration: InputDecoration(
            filled: true,
            hintText: "NOME DA SKILL",
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          )),
    );
  }
}

class ButtonCreateSkills extends StatelessWidget {
  const ButtonCreateSkills({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: SizedBox(
            width: 800,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: inputField,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: () {},
              child: Text('+', style: createPlusIcon),
            )));
  }
}

class DaysInWeekComponents extends StatefulWidget {
  const DaysInWeekComponents(
      {super.key,
      required this.textCheckBoxEveryDay,
      required this.textCheckBoxSameHour});
  final String textCheckBoxEveryDay;
  final String textCheckBoxSameHour;

  @override
  _DaysInWeekComponentsState createState() =>
      _DaysInWeekComponentsState(textCheckBoxEveryDay, textCheckBoxSameHour);
}

class _DaysInWeekComponentsState extends State<DaysInWeekComponents> {
  var textCheckBoxEveryDay;
  var textCheckBoxSameHour;

  _DaysInWeekComponentsState(String _everyDay, String _sameHour) {
    textCheckBoxEveryDay = _everyDay;
    textCheckBoxSameHour = _sameHour;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(children: [
          // Padding(
          //     padding: const EdgeInsets.only(top: 10),
          //     child: Row(
          //       children: [
          //         Text(textCheckBoxEveryDay, style: createSkillsDescription),
          //         Checkbox(
          //           onChanged: (value) => setState(() {
          //             checkBoxIsEnabledEveryDay = !checkBoxIsEnabledEveryDay;
          //           }),
          //           value: checkBoxIsEnabledEveryDay,
          //           activeColor: midPurple,
          //           checkColor: inputField,
          //         )
          //       ],
          //     )),
          const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: SetDateInitialAndFinal()),
          if (!checkBoxIsEnabledEveryDay)
            Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        for (var day in weekDays)
                          Padding(
                              padding:
                                  const EdgeInsets.only(right: 10, bottom: 10),
                              child: SizedBox(
                                height: 35,
                                width: 43,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 0),
                                      backgroundColor: day['enabled']
                                          ? midPurple
                                          : inputField,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  onPressed: () {
                                    setState(() {
                                      day['enabled'] = !day['enabled'];
                                    });
                                  },
                                  child: Text(day['initials'],
                                      style: day['enabled']
                                          ? dayInWeekEnabled
                                          : dayInWeekDisabled),
                                ),
                              )),
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Text(textCheckBoxSameHour,
                                style: createSkillsDescription),
                            Checkbox(
                              onChanged: (value) => setState(() {
                                checkBoxIsEnabledSameHour =
                                    !checkBoxIsEnabledSameHour;
                              }),
                              value: checkBoxIsEnabledSameHour,
                              activeColor: midPurple,
                              checkColor: inputField,
                            )
                          ],
                        )),
                    if (!checkBoxIsEnabledSameHour)
                      Column(
                        children: [
                          HoursInDays(
                            day: 'SEGUNDA:',
                            isVisible: weekDays[0]['enabled'],
                            controllerStart: segStart,
                            controllerEnd: segEnd,
                          ),
                          HoursInDays(
                            day: 'TERÇA:  ',
                            isVisible: weekDays[1]['enabled'],
                            controllerStart: terStart,
                            controllerEnd: terEnd,
                          ),
                          HoursInDays(
                            day: 'QUARTA:',
                            isVisible: weekDays[2]['enabled'],
                            controllerStart: quaStart,
                            controllerEnd: quaEnd,
                          ),
                          HoursInDays(
                            day: 'QUINTA:',
                            isVisible: weekDays[3]['enabled'],
                            controllerStart: quiStart,
                            controllerEnd: quiEnd,
                          ),
                          HoursInDays(
                            day: 'SEXTA: ',
                            isVisible: weekDays[4]['enabled'],
                            controllerStart: sexStart,
                            controllerEnd: sexEnd,
                          ),
                          HoursInDays(
                            day: 'SABADO:',
                            isVisible: weekDays[5]['enabled'],
                            controllerStart: sabStart,
                            controllerEnd: sabEnd,
                          ),
                          HoursInDays(
                            day: 'DOMINGO:',
                            isVisible: weekDays[6]['enabled'],
                            controllerStart: domStart,
                            controllerEnd: domEnd,
                          ),
                        ],
                      )
                    else
                      HoursInDays(
                        day: 'HORARIO:',
                        isVisible: true,
                        controllerStart: sameHourStart,
                        controllerEnd: sameHourEnd,
                      ),
                  ],
                )),
        ]));
  }
}

class HoursInDays extends StatelessWidget {
  const HoursInDays(
      {super.key,
      required this.day,
      required this.isVisible,
      required this.controllerStart,
      required this.controllerEnd});
  final String day;
  final bool isVisible;
  final TextEditingController controllerStart;
  final TextEditingController controllerEnd;

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: isVisible,
        child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 84,
                  child: Text(day, style: createSkillsDescription),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: SizedBox(
                        width: 120,
                        height: 50,
                        child: HounsPickComponent(
                          controller: controllerStart,
                        ))),
                Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: SizedBox(
                        width: 120,
                        height: 50,
                        child: HounsPickComponent(
                          controller: controllerEnd,
                        ))),
              ],
            )));
  }
}

class SetDateInitialAndFinal extends StatefulWidget {
  const SetDateInitialAndFinal({Key? key}) : super(key: key);

  @override
  _SetDateInitialAndFinalState createState() => _SetDateInitialAndFinalState();
}

class _SetDateInitialAndFinalState extends State<SetDateInitialAndFinal> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 84,
          child: Text("PERIODO:", style: createSkillsDescription),
        ),
        Padding(
            padding: const EdgeInsets.only(left: 20),
            child: SizedBox(
                width: 120,
                height: 50,
                child: SetDateComponents(controller: startDate))),
        Padding(
            padding: const EdgeInsets.only(left: 20),
            child: SizedBox(
                width: 120,
                height: 50,
                child: SetDateComponents(controller: endDate))),
      ],
    );
  }
}

class SetDateComponents extends StatefulWidget {
  const SetDateComponents({super.key, required this.controller});
  final TextEditingController controller;

  @override
  _SetDateComponentsState createState() => _SetDateComponentsState(controller);
}

class _SetDateComponentsState extends State<SetDateComponents> {
  var controller;

  _SetDateComponentsState(TextEditingController _controller) {
    controller = _controller;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: TextField(
      textAlign: TextAlign.center,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
        ),
      ),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            lastDate: DateTime(2100));

        if (pickedDate != null) {
          String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
          setState(() {
            controller.text = formattedDate;
          });
        } else {}
      },
    ));
  }
}

class HounsPickComponent extends StatefulWidget {
  const HounsPickComponent({super.key, required this.controller});
  final TextEditingController controller;

  @override
  _HounsPickComponentState createState() =>
      _HounsPickComponentState(controller);
}

class _HounsPickComponentState extends State<HounsPickComponent> {
  TimeOfDay _time = const TimeOfDay(hour: 00, minute: 00);
  var controller;

  _HounsPickComponentState(TextEditingController _controller) {
    controller = _controller;
  }

  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
        var hour = newTime.hour.toString().padLeft(2, '0');
        var minute = newTime.minute.toString().padLeft(2, '0');
        controller.text = '$hour:$minute';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
            width: 120,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  backgroundColor: inputField,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40))),
              onPressed: _selectTime,
              child: Text(
                  "${_time.hour.toString().padLeft(2, '0')}:${_time.minute.toString().padLeft(2, '0')}",
                  style: dayInWeekDisabled),
            )));
  }
}
