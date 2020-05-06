import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_contest/game_end.dart';
import 'package:flutter_contest/question_model.dart';
import 'package:http/http.dart' as http;

import 'option.dart';

class Question extends StatefulWidget {
  Question({Key key, this.startPos, this.name}) : super(key: key);

  final int startPos;
  final String name;

  @override
  _QuestionState createState() => _QuestionState(startPos, name);
}

class _QuestionState extends State<Question> {
  _QuestionState(this.startPos, this.name);

  int totalScore = 0;
  List<QuestionModel> questions = _getQuestions();
  int startPos;
  String name;
  String selectionAnswer = 'Q';
  int _borderEnable;
  int time = 20;
  Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(new Duration(seconds: 1), (timer) {
      if (time == 0) {
        //Diğer Soruya geç
        if (questions.length == startPos + 1) {
          timer.cancel();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EndGame(
                name: name,
                score: totalScore,
              ),
            ),
          );
        }else{
          setState(() {
            startPos++;
            _borderEnable = -1;
            selectionAnswer = 'Q';
            time = 20;
          });
        }
      } else {
        setState(() {
          time--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sorular'), automaticallyImplyLeading: false),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 25.0),
              child: Center(
                child: Text('Süre: $time',
                    style:
                        TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Text(questions[startPos].question,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            //First option
            GestureDetector(
              onTap: () {
                setState(() {
                  _borderEnable = 0;
                  selectionAnswer = 'A';
                });
              },
              child: Container(
                decoration: _borderEnable == 0
                    ? BoxDecoration(border: Border.all(), color: Colors.green)
                    : null,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      questions[startPos].options[0].optionLetter +
                          ' - ' +
                          questions[startPos].options[0].option,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
            //Second Option
            GestureDetector(
              onTap: () {
                setState(() {
                  _borderEnable = 1;
                  selectionAnswer = 'B';
                });
              },
              child: Container(
                  decoration: _borderEnable == 1
                      ? BoxDecoration(border: Border.all(), color: Colors.green)
                      : null,
                  margin: EdgeInsets.only(top: 15),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        questions[startPos].options[1].optionLetter +
                            ' - ' +
                            questions[startPos].options[1].option,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  )),
            ), //Third Option
            GestureDetector(
              onTap: () {
                setState(() {
                  _borderEnable = 2;
                  selectionAnswer = 'C';
                });
              },
              child: Container(
                  decoration: _borderEnable == 2
                      ? BoxDecoration(border: Border.all(), color: Colors.green)
                      : null,
                  margin: EdgeInsets.only(top: 15),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        questions[startPos].options[2].optionLetter +
                            ' - ' +
                            questions[startPos].options[2].option,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  )),
            ), //Fourth Option
            GestureDetector(
              onTap: () {
                setState(() {
                  _borderEnable = 3;
                  selectionAnswer = 'D';
                });
              },
              child: Container(
                  decoration: _borderEnable == 3
                      ? BoxDecoration(border: Border.all(), color: Colors.green)
                      : null,
                  margin: EdgeInsets.only(top: 15),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        questions[startPos].options[3].optionLetter +
                            ' - ' +
                            questions[startPos].options[3].option,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(top: 25),
              child: RaisedButton(
                onPressed: selectionAnswer == 'Q' ? null : clickContinue,
                child: questions.length == startPos + 1
                    ? Text('Bitir')
                    : Text('Devam'),
              ),
            )
          ],
        ),
      ),
    );
  }
  postScore(name, score){
    http.post("https://flutter-contest-api.herokuapp.com/board/postScore",
    //http.post("http://192.168.1.58:8085/board/postScore",
    body: {'name' : name, 'score' : score.toString()});
  }

  clickContinue() {
    if (selectionAnswer == questions[startPos].correctAnswer) {
      totalScore = totalScore + time + 10;
    }

    if (questions.length == startPos + 1) {
      timer.cancel();
      postScore(name, totalScore);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EndGame(
            name: name,
            score: totalScore,
          ),
        ),
      );
    } else {
      setState(() {
        //Diğer Soruya geç
        startPos++;
        _borderEnable = -1;
        selectionAnswer = 'Q';
        time = 20;
      });
    }
  }

  static List<QuestionModel> _getQuestions() {
    List<QuestionModel> list = new List();

    //Soru 1
    QuestionModel qm1 = QuestionModel();
    qm1.question = 'Soru 1: Flutter hangi programlama dilini kullanmaktadır?';
    qm1.options = new List<Option>();
    qm1.options.add(Option(optionLetter: 'A', option: 'Java'));
    qm1.options.add(Option(optionLetter: 'B', option: 'Dart'));
    qm1.options.add(Option(optionLetter: 'C', option: 'Kotlin'));
    qm1.options.add(Option(optionLetter: 'D', option: 'C++'));
    qm1.correctAnswer = 'B';
    list.add(qm1);
    //Soru 2
    QuestionModel qm2 = QuestionModel();
    qm2.question = 'Soru 2: Flutter hangi şirket tarafından oluşturuldu?';
    qm2.options = new List<Option>();
    qm2.options.add(Option(optionLetter: 'A', option: 'Microsoft'));
    qm2.options.add(Option(optionLetter: 'B', option: 'Oracle'));
    qm2.options.add(Option(optionLetter: 'C', option: 'Google'));
    qm2.options.add(Option(optionLetter: 'D', option: 'Hiçbiri'));
    qm2.correctAnswer = 'C';
    list.add(qm2);
    //Soru 3
    QuestionModel qm3 = QuestionModel();
    qm3.question = 'Soru 3: Aşağıdakilerden hangisi dart dili için söylenemez?';
    qm3.options = new List<Option>();
    qm3.options.add(Option(optionLetter: 'A', option: 'Strongly typed bir dildir'));
    qm3.options.add(Option(optionLetter: 'B', option: 'Javascripte rakip olarak ortaya çıkmıştır'));
    qm3.options.add(Option(optionLetter: 'C', option: 'Bir programlama dilidir'));
    qm3.options.add(Option(optionLetter: 'D', option: 'Nesne tabanlı değildir'));
    qm3.correctAnswer = 'D';
    list.add(qm3);
    //Soru 4
    QuestionModel qm4 = QuestionModel();
    qm4.question = 'Soru 4: Flutter Frameworkü aşağıdaki hangi yapıyı kullanıcılara sunmuştur?';
    qm4.options = new List<Option>();
    qm4.options.add(Option(optionLetter: 'A', option: 'String'));
    qm4.options.add(Option(optionLetter: 'B', option: 'Class'));
    qm4.options.add(Option(optionLetter: 'C', option: 'Component'));
    qm4.options.add(Option(optionLetter: 'D', option: 'Widget'));
    qm4.correctAnswer = 'D';
    list.add(qm4);
    //Soru 5
    QuestionModel qm5 = QuestionModel();
    qm5.question = "Soru 5: Aşağıdakilerden hangisi Flutter'ın özelliklerinden değildir?";
    qm5.options = new List<Option>();
    qm5.options.add(Option(
        optionLetter: 'A', option: 'Hot Reload ile hızlı geliştirme'));
    qm5.options.add(Option(optionLetter: 'B', option: 'JIT / AOT Compiler yapabilmesi'));
    qm5.options.add(Option(optionLetter: 'C', option: 'Cross Platforms olması'));
    qm5.options.add(Option(optionLetter: 'D', option: 'Sadece Androide hizmet ediyor oluşu'));
    qm5.correctAnswer = 'D';
    list.add(qm5);
    return list;
  }
}
