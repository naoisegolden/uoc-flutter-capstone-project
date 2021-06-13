import 'package:capstone_project/widgets/character_card_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CharacterScreen extends StatelessWidget {
  static const String id = '/character';

  CharacterScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context).settings.arguments as Map;
    final characters = context.read<List>();
    final character = characters
        .firstWhere((character) => character['id'] == arguments['characterId']);

    return Scaffold(
      appBar: AppBar(
        title: Text(character['name']),
      ),
      body: Padding(
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
            )
          ],
        ),
      ),
    );
  }

  void _launchURL(url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
}
