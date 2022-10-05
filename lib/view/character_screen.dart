import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:this_is_me/model/character.dart';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({super.key, required this.character});
  final Character character;
  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
          children: [(Center(child: Text(widget.character.characterName)))]),
    );
  }
}
