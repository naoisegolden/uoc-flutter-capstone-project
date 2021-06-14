import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

const LOADED_ITEMS = 20;

class MarvelCharacters with ChangeNotifier {
  dynamic _characters = [];
  dynamic _offset = 0;

  dynamic get characters => _characters;

  set characters(dynamic newCharacters) {
    _characters = newCharacters;
    notifyListeners();
  }

  MarvelCharacters() {
    fetchCharacters();
  }

  Future fetchCharacters() async {
    var loadedCharacters;

    await dotenv.load();

    // Generate hash for API authentication
    var ts = DateTime.now().millisecondsSinceEpoch.toString();
    var apiKey = dotenv.env['MARVEL_API_PUBLIC_KEY'];
    var privateKey = dotenv.env['MARVEL_API_PRIVATE_KEY'];
    var unhashed = ts + privateKey + apiKey;
    var hash = md5.convert(utf8.encode(unhashed)).toString();

    var url = Uri.https('gateway.marvel.com', '/v1/public/characters', {
      'ts': ts,
      'apikey': apiKey,
      'hash': hash,
      'limit': LOADED_ITEMS.toString(),
      'offset': _offset.toString(),
    });

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      loadedCharacters = jsonResponse['data']['results'];
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    // Update offset and add new loaded characters to list
    _offset = _offset + LOADED_ITEMS;
    characters = characters + loadedCharacters;
  }
}
