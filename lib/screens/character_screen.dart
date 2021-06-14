import 'package:capstone_project/screens/comics_screen.dart';
import 'package:capstone_project/widgets/character_card_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../MarvelCharacters.dart';

class CharacterScreen extends StatelessWidget {
  static const String id = '/character';

  CharacterScreen();

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context).settings.arguments as Map;
    final characters = context.watch<MarvelCharacters>().characters;
    final character = characters
        .firstWhere((character) => character['id'] == arguments['characterId']);
    final name = character['name'];
    final comics = character['comics']['items'];
    final availableComics = character['comics']['available'];

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            CharacterCardData(character),
            SizedBox(height: 24.0),
            Text(character['description'].isEmpty
                ? 'No description available.'
                : character['description']),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () async {
                var url = character['urls']
                    .firstWhere((url) => url['type'] == 'detail')['url'];

                try {
                  // ignore: await_only_futures
                  await _launchURL(url);
                } catch (error) {
                  final snackBar = SnackBar(content: Text(error));

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: Text('Visit on-line profile'),
            ),
            SizedBox(height: 24.0),
            Text('$name appears in $availableComics comic books:'),
            SizedBox(height: 8.0),
            Column(
                children: comics
                    .take(5)
                    .map<Widget>((comic) => Text(
                          comic['name'],
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.black54),
                        ))
                    .toList()),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, ComicsScreen.id,
                    arguments: {'characterId': character['id']});
              },
              child: Text('See complete list'),
            ),
          ],
        ),
      )),
    );
  }

  void _launchURL(url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
}
