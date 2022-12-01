// ignore_for_file: no_leading_underscores_for_local_identifiers, no_logic_in_create_state, library_private_types_in_public_api, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:intl/intl.dart';
import 'package:this_is_me/constants/app_colors.dart';
import 'package:this_is_me/constants/app_fonts.dart';

TextEditingController nameController = TextEditingController();
TextEditingController descriptionController = TextEditingController();
TextEditingController dateStartInput = TextEditingController();
TextEditingController dateEndInput = TextEditingController();

Color selectedColor = Colors.red;
bool checkBoxIsEnabledEveryDay = false;
bool checkBoxIsEnabledSameHour = false;
List weekDays = [
  {
    "enabled": false,
    "name": "SEGUNDA",
    "initials": "Seg",
  },
  {
    "enabled": false,
    "name": "TERÇA",
    "initials": "Ter",
  },
  {
    "enabled": false,
    "name": "QUARTA",
    "initials": "Qua",
  },
  {
    "enabled": false,
    "name": "QUINTA",
    "initials": "Qui",
  },
  {
    "enabled": false,
    "name": "SEXTA",
    "initials": "Sex",
  },
  {
    "enabled": false,
    "name": "SABADO",
    "initials": "Sab",
  },
  {
    "enabled": false,
    "name": "DOMINGO",
    "initials": "Dom",
  }
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
            onPressed: () {},
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
          Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Text(textCheckBoxEveryDay, style: createSkillsDescription),
                  Checkbox(
                    onChanged: (value) => setState(() {
                      checkBoxIsEnabledEveryDay = !checkBoxIsEnabledEveryDay;
                    }),
                    value: checkBoxIsEnabledEveryDay,
                    activeColor: midPurple,
                    checkColor: inputField,
                  )
                ],
              )),
          const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
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
                          ),
                          HoursInDays(
                            day: 'TERÇA:  ',
                            isVisible: weekDays[1]['enabled'],
                          ),
                          HoursInDays(
                            day: 'QUARTA:',
                            isVisible: weekDays[2]['enabled'],
                          ),
                          HoursInDays(
                            day: 'QUINTA:',
                            isVisible: weekDays[3]['enabled'],
                          ),
                          HoursInDays(
                            day: 'SEXTA: ',
                            isVisible: weekDays[4]['enabled'],
                          ),
                          HoursInDays(
                            day: 'SABADO:',
                            isVisible: weekDays[5]['enabled'],
                          ),
                          HoursInDays(
                            day: 'DOMINGO:',
                            isVisible: weekDays[6]['enabled'],
                          ),
                        ],
                      )
                    else
                      const HoursInDays(
                        day: 'HORARIO:',
                        isVisible: true,
                      ),
                  ],
                )),
        ]));
  }
}

class HoursInDays extends StatelessWidget {
  const HoursInDays({super.key, required this.day, required this.isVisible});
  final String day;
  final bool isVisible;

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
                        child: TextField(
                            textAlign: TextAlign.center,
                            controller: TextEditingController(),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "INICIO",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                            )))),
                Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: SizedBox(
                        width: 120,
                        height: 50,
                        child: TextField(
                            textAlign: TextAlign.center,
                            controller: TextEditingController(),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "FIM",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                            )))),
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
            padding: EdgeInsets.only(left: 20),
            child: SizedBox(
                width: 120,
                height: 50,
                child: SetDateComponents(controller: dateStartInput))),
        Padding(
            padding: EdgeInsets.only(left: 20),
            child: SizedBox(
                width: 120,
                height: 50,
                child: SetDateComponents(
                  controller: dateEndInput,
                ))),
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

                          // 