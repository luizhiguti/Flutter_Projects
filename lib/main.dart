// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'dart:async' show Future;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'City Name Generator',
      home: RandomWords(),
    );
  }
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <String>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  var fileContents = <String>[];
  
  @override
  Widget build(BuildContext context) {
    loadAsset().then((contents) {
      setState(() {
      });
        fileContents = contents.split("\n");
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('City Name Generator'),
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildRow(String string) {
    return ListTile(
      title: Text(
        string,
        style: _biggerFont,
      ),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.add(fileContents[index]); /*4*/
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Future<String> loadAsset() async {
    String fileContents = await rootBundle.loadString('assets/Cidades-SP.txt');
    return fileContents;
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}
