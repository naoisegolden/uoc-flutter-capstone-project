import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:provider/provider.dart';

import 'screens/character_screen.dart';
import 'screens/home_screen.dart';

Future fetchCharacters() async {}

Future main() async {
  var characters = [];

  await dotenv.load();

  // Generate hash for API authentication
  var ts = DateTime.now().millisecondsSinceEpoch.toString();
  var apiKey = dotenv.env['MARVEL_API_PUBLIC_KEY'];
  var privateKey = dotenv.env['MARVEL_API_PRIVATE_KEY'];
  var unhashed = ts + privateKey + apiKey;
  var hash = md5.convert(utf8.encode(unhashed)).toString();

  var url = Uri.https('gateway.marvel.com', '/v1/public/characters',
      {'ts': ts, 'apikey': apiKey, 'hash': hash, 'limit': '100'});

  // Await the http get response, then decode the json-formatted response.
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
    characters = jsonResponse['data']['results'];
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }

  runApp(Provider(
    create: (_) => characters,
    child: MyApp(),
  ));
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
