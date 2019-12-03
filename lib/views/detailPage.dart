import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/video.dart';
import '../model/detailData.dart';
import './detailDataCell.dart';

import 'dart:convert';

class DetailPage extends StatefulWidget {
  final Video video;
  DetailPage(this.video);
  @override
  State<StatefulWidget> createState() {
    return new DetailPageState(video);
  }
}

class DetailPageState extends State<DetailPage> {
  final Video video;
  final detail = new List<DetailData>();
  var _loading = true;
  DetailPageState(this.video);

  @override
  void initState() {
    super.initState();
    _fetchDetail();
  }

  _fetchDetail() async {
    final url = "https://api.letsbuildthatapp.com/youtube/course_detail?id=" +
        video.id.toString();
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final detailJson = json.decode(response.body);
      detailJson.forEach((d) {
        final data = new DetailData(
            d["name"], d["imageUrl"], d["duration"], d["number"]);
        detail.add(data);
      });
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(title: new Text(video.name)),
        body: new Center(
            child: _loading
                ? new CircularProgressIndicator()
                : new ListView.builder(
                    itemCount: detail.length,
                    itemBuilder: (context, i) {
                      final d = detail[i];
                      return new DetailDataCell(d);
                    },
                  )));
  }
}
