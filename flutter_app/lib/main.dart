import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final wordPair = WordPair.random();
    return MaterialApp(
      title: 'Startup Name Generator',
      home: RandomWords(),
    );
  }
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        // itemBuilderコールバックは、単語のペアリングごとに1回呼び出され、
        // 各単語をListTileに配置します。
        // 偶数行の場合、この関数はペアリングされた単語をListTileに追加します。
        // 奇数行の場合、この関数はリストを視覚的に区切るための
        // Dividerウィジェットを追加します。
        // Dividerは小型デバイスでは見づらい場合があります。
        itemBuilder: (BuildContext _context, int i) {
          // ListViewの各行の前に1ピクセルの高さの
          // 仕切りウィジェット(Divider)を追加します。
          if (i.isOdd) {
            return Divider();
          }

          // 構文 "i〜/ 2"は、iを2で除算して整数の結果を返します。
          // 例えば、iが1、2、3、4、5の場合は0、1、1、2、2となります。
          // これは、ListView内の実際の単語の組み合わせ数から、
          //仕切りウィジェットを差し引いた数を計算します。
          final int index = i ~/ 2;
          // 利用可能な単語の組み合わせの終わりに達した場合は...
          if (index >= _suggestions.length) {
            // ...さらに10個生成し、それらを候補リストに追加します。
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        }
    );
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}