import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/character_card.dart';

class HomeScreen extends StatelessWidget {
  static const String id = '/home';

  HomeScreen();

  @override
  Widget build(BuildContext context) {
    final characters = context.read<List>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Capstone Project: Marvel Characters'),
      ),
      body: Center(
        child: ListView.builder(
          padding: EdgeInsets.all(16.0),
          itemCount: characters == null ? 0 : characters.length,
          itemBuilder: (BuildContext context, int index) {
            return CharacterCard(characters[index]);
          },
          // child: ListView(
          //   children: characters
          //       .map((character) => Container(
          //             height: 50,
          //             color: Colors.amber[600],
          //             child: Center(child: Text(character['name'])),
          //           ))
          //       .toList(),
        ),
      ),
    );
  }
}
