import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../MarvelCharacters.dart';

class ComicsScreen extends StatelessWidget {
  static const String id = '/comics';

  ComicsScreen();

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context).settings.arguments as Map;
    final characters = context.watch<MarvelCharacters>().characters;
    final character = characters
        .firstWhere((character) => character['id'] == arguments['characterId']);
    final comics = character['comics']['items'];
    final characterName = character['name'];

    return Scaffold(
        appBar: AppBar(
          title: Text('Comics where $characterName appears'),
        ),
        body: ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: comics == null ? 0 : comics.length,
            itemBuilder: (BuildContext context, int index) {
              final name = comics[index]['name'];
              return Card(
                child: Stack(children: [
                  SizedBox(
                      width: 400,
                      height: 150,
                      child: Semantics(
                          label: 'The cover $name comic book',
                          child: Image.asset(
                            'assets/marvel-comic.jpg',
                            fit: BoxFit.cover,
                          ))),
                  Positioned.fill(
                    child: Container(
                        color: Colors.black.withAlpha(100),
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Semantics(
                            label: 'Comic book name',
                            child: Text(
                              name,
                              style: TextStyle(
                                // fontSize: 28.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    blurRadius: 5.0,
                                    color: Colors.black,
                                    offset: Offset(0.0, 1.0),
                                  ),
                                ],
                              ),
                            ))),
                  ),
                ]),
              );
            }));
  }
}
