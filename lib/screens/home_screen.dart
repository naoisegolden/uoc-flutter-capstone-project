import 'package:capstone_project/MarvelCharacters.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../widgets/character_card.dart';

class HomeScreen extends StatelessWidget {
  static const String id = '/home';

  HomeScreen();

  @override
  Widget build(BuildContext context) {
    var characters = context.watch<MarvelCharacters>().characters;
    return Scaffold(
      appBar: AppBar(
        title: Text('Capstone Project: Marvel Characters'),
      ),
      body: Center(
        child: characters.length > 0
            ? ListView.builder(
                padding: EdgeInsets.all(16.0),
                itemCount: characters == null ? 0 : characters.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index == characters.length - 1) {
                    // Fetch next page on reaching last item
                    print('bottom reached');
                  }
                  return CharacterCard(characters[index]);
                },
              )
            : SpinKitCircle(
                color: Colors.pink,
                size: 50.0,
              ),
      ),
    );
  }
}
