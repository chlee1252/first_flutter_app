import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  var _Loading = true;
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("MY FIRST FLUTTER APP"),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.refresh),
              onPressed: () {
                _Loading = false;
              },
            )
          ],
        ),
        body: new Center(
          child: _Loading
              ? new CircularProgressIndicator()
              : new Text("Done Loading!"),
        ),
      ),
    );
  }
}
