import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './views/dataCell.dart';
import './views/detailPage.dart';
import './model/video.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  var _loading = true;
  var videoData = new List<Video>();
  final url = "https://api.letsbuildthatapp.com/youtube/home_feed";

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  _fetchData() async {
    videoData.clear();
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final map = json.decode(response.body);
      map["videos"].forEach((v) {
        final data =
            new Video(v["id"], v["name"], v["imageUrl"], v["numberOfViews"]);
        videoData.add(data);
      });

      // For circular progress bar to false if it is succeed loading data
      setState(() {
        _loading = false;
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
                  _loading = true;
                });
                _fetchData();
              },
            )
          ],
        ),
        body: new Center(
          child: _loading
              ? new CircularProgressIndicator()
              : new ListView.builder(
                  itemCount: this.videoData != null ? this.videoData.length : 0,
                  itemBuilder: (context, i) {
                    final video = this.videoData[i];
                    return new FlatButton(
                      padding: new EdgeInsets.all(0.0),
                      child: new VideoDataCell(video),
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new DetailPage(video)));
                      },
                    );
                  },
                ),
        ),
      ),
    );
  }
}
