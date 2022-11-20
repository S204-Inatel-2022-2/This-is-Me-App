import 'package:auto_size_text/auto_size_text.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:this_is_me/components/quest_components.dart';
import 'package:this_is_me/constants/app_colors.dart';
import 'package:this_is_me/constants/app_fonts.dart';
import 'package:this_is_me/controller/character_controller.dart';
import 'package:http/http.dart' as http;
import 'package:this_is_me/controller/user_controller.dart';
import 'package:this_is_me/model/character.dart';
import 'package:this_is_me/model/exception/response_exception.dart';
import 'package:this_is_me/view/quest/quest_screen.dart';

int bottomSelectedIndex = 0;

class QuestCardViewer extends StatelessWidget {
  const QuestCardViewer({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const QuestPage(),
    );
  }
}

class QuestPage extends StatefulWidget {
  const QuestPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _QuestPageState createState() => _QuestPageState();
}

class _QuestPageState extends State<QuestPage> {
  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return [
      BottomNavigationBarItem(
          icon: Image.asset(
            'assets/images/personagemFem1.png',
            height: 50,
          ),
          label: '1'),
      BottomNavigationBarItem(
          icon: Image.asset(
            'assets/images/personagemMasc1.png',
            height: 50,
          ),
          label: '2'),
    ];
  }

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: const <Widget>[
        WeeklyQuests(),
        TodayQuests(),
        NextWeekQuests(),
        LateQuests()
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.animateToPage(index,
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(child: buildPageView());
  }
}

// weekly
class WeeklyQuests extends StatefulWidget {
  const WeeklyQuests({super.key});

  @override
  State<WeeklyQuests> createState() => _WeeklyQuestsState();
}

class _WeeklyQuestsState extends State<WeeklyQuests>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 34,
      right: 34,
      top: 270,
      bottom: 50,
      child: Padding(
          padding:
              const EdgeInsets.only(top: 270, bottom: 120, left: 20, right: 20),
          child: SizedBox(
            height: 100,
            width: 340,
            child: BlurryContainer(
              color: Colors.grey.withOpacity(0.5),
              child: Column(children: [
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: SizedBox(
                          width: 150,
                          child: AutoSizeText(
                            'Quests Semanais',
                            style: questContainerTitle,
                          ))),
                  const Padding(
                      padding: EdgeInsets.only(left: 120),
                      child: FloatingActionButton.small(
                        onPressed: null,
                        backgroundColor: midPurple,
                        child: Icon(Icons.add),
                      ))
                ]),
                const Expanded(child: WeeklyQuestList())
              ]),
            ),
          )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

//today
class TodayQuests extends StatefulWidget {
  const TodayQuests({super.key});

  @override
  State<TodayQuests> createState() => _TodayQuestsState();
}

class _TodayQuestsState extends State<TodayQuests>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 34,
      right: 34,
      top: 270,
      bottom: 50,
      child: Padding(
          padding:
              const EdgeInsets.only(top: 270, bottom: 120, left: 20, right: 20),
          child: SizedBox(
            height: 100,
            width: 340,
            child: BlurryContainer(
              color: Colors.grey.withOpacity(0.5),
              child: Column(children: [
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: SizedBox(
                          width: 150,
                          child: AutoSizeText(
                            'Quests do Dia',
                            style: questContainerTitle,
                          ))),
                  const Padding(
                      padding: EdgeInsets.only(left: 120),
                      child: FloatingActionButton.small(
                        onPressed: null,
                        backgroundColor: midPurple,
                        child: Icon(Icons.add),
                      ))
                ]),
                Expanded(child: TodayQuestList())
              ]),
            ),
          )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

//Next week
class NextWeekQuests extends StatefulWidget {
  const NextWeekQuests({super.key});

  @override
  State<NextWeekQuests> createState() => _NextWeekQuestsState();
}

class _NextWeekQuestsState extends State<NextWeekQuests>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 34,
      right: 34,
      top: 270,
      bottom: 50,
      child: Padding(
          padding:
              const EdgeInsets.only(top: 270, bottom: 120, left: 20, right: 20),
          child: SizedBox(
            height: 100,
            width: 340,
            child: BlurryContainer(
              color: Colors.grey.withOpacity(0.5),
              child: Column(children: [
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: SizedBox(
                          width: 150,
                          child: AutoSizeText(
                            'Quests da Próx. Semana',
                            style: questContainerTitle,
                          ))),
                  const Padding(
                      padding: EdgeInsets.only(left: 120),
                      child: FloatingActionButton.small(
                        onPressed: null,
                        backgroundColor: midPurple,
                        child: Icon(Icons.add),
                      ))
                ]),
                Expanded(child: TodayQuestList())
              ]),
            ),
          )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

//Next week
class LateQuests extends StatefulWidget {
  const LateQuests({super.key});

  @override
  State<LateQuests> createState() => _LateQuestsState();
}

class _LateQuestsState extends State<LateQuests>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 34,
      right: 34,
      top: 270,
      bottom: 50,
      child: Padding(
          padding:
              const EdgeInsets.only(top: 270, bottom: 120, left: 20, right: 20),
          child: SizedBox(
            height: 100,
            width: 340,
            child: BlurryContainer(
              color: Colors.grey.withOpacity(0.5),
              child: Column(children: [
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: SizedBox(
                          width: 150,
                          child: AutoSizeText(
                            'Quests Atrasadas',
                            style: questContainerTitle,
                          ))),
                  const Padding(
                      padding: EdgeInsets.only(left: 120),
                      child: FloatingActionButton.small(
                        onPressed: null,
                        backgroundColor: midPurple,
                        child: Icon(Icons.add),
                      ))
                ]),
                Expanded(child: TodayQuestList())
              ]),
            ),
          )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
