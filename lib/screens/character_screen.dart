import 'package:capstone_project/widgets/character_card_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CharacterCardData(character),
            SizedBox(height: 24.0),
            Text(character['description'].isEmpty
                ? character['description']
                : 'No description available.'),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () => {
                //...
              },
              child: Text('Visit on-line profile'),
            )
          ],
        ),
      ),
    );
  }
}
