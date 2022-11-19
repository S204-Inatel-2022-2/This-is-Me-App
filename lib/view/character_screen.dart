import 'package:flutter/material.dart';
import 'package:this_is_me/constants/app_colors.dart';
import 'package:this_is_me/constants/app_fonts.dart';
import 'package:this_is_me/controller/character_controller.dart';
import 'package:http/http.dart' as http;
import 'package:this_is_me/controller/user_controller.dart';
import 'package:this_is_me/model/character.dart';
import 'package:this_is_me/model/exception/response_exception.dart';
import 'package:this_is_me/view/quest_screen.dart';

class CreateCharacterScreen extends StatelessWidget {
  const CreateCharacterScreen({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}
int bottomSelectedIndex = 0;
class _MyHomePageState extends State<MyHomePage> {

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
      children: const <Widget>[Option1(), Option2()],
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
    return Scaffold(
      backgroundColor: background,
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 80, bottom: 15),
              child: Text(
                'Escolha seu personagem',
                style: createCharacterName,
              )),
          Expanded(child: buildPageView()),
          const AdvanceButton()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        backgroundColor: background,
        currentIndex: bottomSelectedIndex,
        onTap: (index) {
          bottomTapped(index);
        },
        items: buildBottomNavBarItems(),
      ),
    );
  }
}

class Option1 extends StatelessWidget {
  const Option1({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/images/personagemFem1.png',
        height: 550,
      ),
    );
  }
}

class Option2 extends StatelessWidget {
  const Option2({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/images/personagemMasc1.png',
        height: 550,
      ),
    );
  }
}

class AdvanceButton extends StatefulWidget {
  const AdvanceButton({super.key});

  @override
  State<AdvanceButton> createState() => _AdvanceButtonState();
}

class _AdvanceButtonState extends State<AdvanceButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: SizedBox(
          height: 50,
          width: 130,
          child: ElevatedButton(
              onPressed: () async {
                var response = await setClothes(http.Client(), bottomSelectedIndex);
                if (response == 200) {
                  var characterResponse = await getCharacter(http.Client());
                  if (characterResponse is Character) {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => QuestScreen(character: characterResponse,)), (route) => false);
                  }
                }else if(response is ResponseException){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.message)));
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: midPurple,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: Text(
                'AVANÇAR',
                style: registrationButton,
              )),
        ));
  }
}
