import 'package:flutter/material.dart';

class CharacterCardData extends StatelessWidget {
  final character;

  const CharacterCardData(this.character);

  @override
  Widget build(BuildContext context) {
    var name = character['name'];
    var path = character['thumbnail']['path'];
    var extension = character['thumbnail']['extension'];

    return Stack(children: [
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
                ))),
      ),
    ]);
  }
}
