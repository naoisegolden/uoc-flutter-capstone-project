import 'package:flutter/material.dart';

import '../screens/character_screen.dart';
import 'character_card_data.dart';

class CharacterCard extends StatelessWidget {
  final character;

  const CharacterCard(this.character);

  @override
  Widget build(BuildContext context) {
    return Semantics(
        label: 'Character Card',
        hint: 'Tapping will open the character\'s details page',
        button: true,
        child: Card(
            child: Material(
                color: Colors.transparent,
                child: InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //         CharacterScreen(character: character),
                      //   ),
                      // );
                      Navigator.pushNamed(context, CharacterScreen.id,
                          arguments: {'characterId': character['id']});
                    },
                    child: CharacterCardData(character)))));
  }
}
