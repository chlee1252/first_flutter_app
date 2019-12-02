import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//practice API: api.letsbuildthatapp.com/youtube/home_feed

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  var _loading = true;
  final url = "https://api.letsbuildthatapp.com/youtube/home_feed";

  _fetchData() async {
    print("fetching Data");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final map = json.decode(response.body);
      final videos = map["videos"];
      videos.forEach((video) {
        print(video["name"]);
      });
    }
  }

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
                setState(() {
                  _loading = false;
                });
                _fetchData();
              },
            )
          ],
        ),
        body: new Center(
          child: _loading
              ? new CircularProgressIndicator()
              : new Text("Done Loading!"),
        ),
      ),
    );
  }
}
