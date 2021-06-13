import 'package:flutter/material.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard(this.character);

  final character;

  @override
  Widget build(BuildContext context) {
    var path = character['thumbnail']['path'];
    var extension = character['thumbnail']['extension'];
    var name = character['name'];

    return Semantics(
        label: 'Character Card',
        hint: 'Tapping will open the character\'s details page',
        button: true,
        child: Card(
            child: Stack(children: [
          SizedBox(
              width: 400,
              height: 150,
              child: Semantics(
                  label: 'An image of $name',
                  child: Image.network(
                    '$path.$extension',
                    fit: BoxFit.cover,
                  ))),
          Positioned.fill(
            child: Material(
                color: Colors.transparent,
                child: InkWell(
                    onTap: () {
                      print('Card tapped.');
                    },
                    child: Container(
                        color: Colors.black.withAlpha(100),
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Semantics(
                            label: 'Character\'s name',
                            child: Text(
                              name,
                              style: TextStyle(
                                fontSize: 28.0,
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
                            ))))),
          ),
        ])));
  }
}
