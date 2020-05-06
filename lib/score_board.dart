import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Score.dart';

class ScoreBoard extends StatefulWidget {
  @override
  _ScoreBoardState createState() => _ScoreBoardState();
}

class _ScoreBoardState extends State<ScoreBoard> {
  Timer timer;
  var scores = new List<Score>();

  @override
  Widget build(BuildContext context) {
    return (ListView.builder(
      itemCount: scores.length,
      itemBuilder: (context, index) {
        return ListTile(
            title: Text(scores[index].name + ' - ' + scores[index].score));
      },
    ));
  }

  @override
  void initState() {
    timer = Timer.periodic(new Duration(seconds: 3), (timer) {
      var response =
          http.get("https://flutter-contest-api.herokuapp.com/board/getBoard");
      //http.get("http://192.168.1.58:8085/board/getBoard");

      print(response);
      response.then((res) {
        Iterable list = json.decode(res.body);
        setState(() {
          scores = list.map((model) => Score.fromJson(model)).toList();
        });
      });
    });
  }
/*
  @override
  void initState() {
      var response =
      //http.get("https://flutter-contest-api.herokuapp.com/board/getBoard");
      http.get("http://192.168.1.58:8085/board/getBoard");

      print(response);
      response.then((res) {
        Iterable list = json.decode(res.body);
        setState(() {
          scores = list.map((model) => Score.fromJson(model)).toList();
        });
      });
      print(scores);
  }*/
}
