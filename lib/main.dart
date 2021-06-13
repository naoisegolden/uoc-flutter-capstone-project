import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:provider/provider.dart';

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
      {'ts': ts, 'apikey': apiKey, 'hash': hash});

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
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Capstone Project: Marvel Characters'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final data = context.read<List>();
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) {
            return new Container(
                height: 50,
                color: Colors.amber[index % 2 == 0 ? 200 : 100],
                child: Center(child: new Text(data[index]['name'])));
          },
          // child: ListView(
          //   children: data
          //       .map((character) => Container(
          //             height: 50,
          //             color: Colors.amber[600],
          //             child: Center(child: Text(character['name'])),
          //           ))
          //       .toList(),
        ),
      ),
    );
  }
}
