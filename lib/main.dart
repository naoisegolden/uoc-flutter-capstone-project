import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/character_screen.dart';
import 'screens/home_screen.dart';

import 'MarvelCharacters.dart';

Future main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MarvelCharacters()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Capstone Project',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        textTheme: TextTheme(
          bodyText2: TextStyle(fontSize: 18.0),
          button: TextStyle(fontSize: 18.0),
        ),
        fontFamily: 'FrancoisOne',
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        }),
      ),
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        CharacterScreen.id: (context) => CharacterScreen(),
      },
    );
  }
}
