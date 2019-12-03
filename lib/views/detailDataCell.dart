import 'package:flutter/material.dart';

import '../model/detailData.dart';

class DetailDataCell extends StatelessWidget {
  final DetailData d;

  DetailDataCell(this.d);

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Container(
            child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Image.network(
              d.imageURL,
              width: 150.0,
            ),
            new Container(width: 12.0),
            new Flexible(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(d.name, style: new TextStyle(fontSize: 16.0)),
                  new Container(
                    height: 4.0,
                  ),
                  new Text(
                    d.duration,
                    style: new TextStyle(fontStyle: FontStyle.italic),
                  ),
                  new Container(
                    height: 4.0,
                  ),
                  new Text("Episode " + d.number.toString(),
                      style: new TextStyle(fontWeight: FontWeight.bold))
                ],
              ),
            )
          ],
        )),
        new Divider()
      ],
    );
  }
}
