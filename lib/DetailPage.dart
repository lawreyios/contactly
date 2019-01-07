import 'package:flutter/material.dart';
import 'model/Record.dart';
import 'helpers/URLLauncher.dart';

class DetailPage extends StatelessWidget {
  final Record record;
  DetailPage({Key key, this.record}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(record.name),
        ),
        body: new ListView(
            children: <Widget>[
              Hero(
                tag: "avatar_" + record.name,
                child: new Image.network(
                    record.photo
                ),
              ),
              GestureDetector(
                onTap: () {
                  URLLauncher().launchURL(record.url);
                },
                child: new Container(
                  padding: const EdgeInsets.all(32.0),
                  child: new Row(
                    children: [
                      // First child in the Row for the name and the
                      // Release date information.
                      new Expanded(
                        // Name and Release date are in the same column
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Code to create the view for name.
                            new Container(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: new Text(
                                "Name: " + record.name,
                                style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            // Code to create the view for release date.
                            new Text(
                              "Address: " + record.address,
                              style: new TextStyle(
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Icon to indicate the rating.
                      new Icon(
                        Icons.phone,
                        color: Colors.red[500],
                      ),
                      new Text('${record.contact}'),
                    ],
                  ),
                )
              ),
            ]
        )
    );
  }


}