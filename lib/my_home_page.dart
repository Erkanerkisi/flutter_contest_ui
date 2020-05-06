import 'package:flutter/material.dart';
import './question.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String name;

  _onChanged(value) {
    setState(() {
      name = value;
    });
  }

  start() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Question(name: name, startPos: 0,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Text('Hoşgeldiniz',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _onChanged,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Adınızı Giriniz',
              ),
            ),
          ),
          RaisedButton(
            onPressed: name != '' ? start : null,
            child: Text('Başlayalım mı?'),
          )
        ],
      )),
    );
  }
}
