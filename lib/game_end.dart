import 'package:flutter/material.dart';
import 'package:flutter_contest/score_board.dart';

class EndGame extends StatelessWidget{

  EndGame({this.score, this.name});

  final int score;
  final String name;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Sonuçlar'),automaticallyImplyLeading: false),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top : 20, bottom: 10.0),
              child: Text('Teşekkürler $name',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('Skorunuz: $score',
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text('Score Board',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, decoration: TextDecoration.underline,)),
            ),
            Expanded(child: ScoreBoard())
          ],
        ),
      ),
    );;
  }
}