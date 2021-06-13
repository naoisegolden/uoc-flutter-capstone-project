import 'package:flutter/material.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard(this.character);

  final character;

  @override
  Widget build(BuildContext context) {
    var path = character['thumbnail']['path'];
    var extension = character['thumbnail']['extension'];

    return Card(
        child: Stack(children: [
      SizedBox(
          width: 400,
          height: 150,
          child: Image.network(
            '$path.$extension',
            fit: BoxFit.cover,
          )),
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
                    child: Text(
                      character['name'],
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
                    )))),
      ),
    ]));
  }
}
