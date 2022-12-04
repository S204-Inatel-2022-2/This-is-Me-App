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
import 'package:this_is_me/view/createQuest_screen.dart';
import 'package:this_is_me/view/quest/quest_screen.dart';

int bottomSelectedIndex = 0;

class QuestCardTopControll extends StatelessWidget {
  const QuestCardTopControll({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Padding(
          padding: const EdgeInsets.only(left: 15),
          child: SizedBox(
              width: 150,
              child: AutoSizeText(
                title,
                style: questContainerTitle,
              ))),
      Padding(
          padding: const EdgeInsets.only(left: 90, right: 20),
          child: FloatingActionButton.small(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CreateQuestScreen())),
            backgroundColor: midPurple,
            child: const Icon(Icons.add),
          ))
    ]);
  }
}

class QuestViewer extends StatelessWidget {
  const QuestViewer({Key? key}) : super(key: key);

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
        QuestCardLoader(
          questCardTitle: 'Quests Semanais',
          questList: WeeklyQuestList(),
        ),
        QuestCardLoader(
          questCardTitle: 'Quests do Dia',
          questList: TodayQuestList(),
        ),
        QuestCardLoader(
          questCardTitle: 'Quests da Próx. Semana',
          questList: NextWeekQuestList(),
        ),
        QuestCardLoader(
          questCardTitle: 'Quests Atrasadas',
          questList: LateQuestList(),
        ),
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
    return buildPageView();
  }
}

// weekly
class QuestCardLoader extends StatefulWidget {
  const QuestCardLoader(
      {super.key, required this.questCardTitle, required this.questList});

  final String questCardTitle;
  final Widget questList;
  @override
  State<QuestCardLoader> createState() => _QuestCardLoaderState();
}

class _QuestCardLoaderState extends State<QuestCardLoader>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 270, bottom: 120, left: 20, right: 20),
      child: SizedBox(
          height: 100,
          width: 340,
          child: BlurryContainer(
            color: Colors.grey.withOpacity(0.5),
            child: Column(children: [
              QuestCardTopControll(
                title: widget.questCardTitle,
              ),
              Expanded(child: widget.questList)
            ]),
          )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
