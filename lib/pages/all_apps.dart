import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(new MaterialApp(
    home: new AllAppsScreen(),
  ));
}

class AllAppsScreen extends StatefulWidget {
  @override
  AllAppsState createState() => new AllAppsState();
}

class AllAppsState extends State<AllAppsScreen> {
  List data;

  Future<String> getData(context) async {
    var response = await DefaultAssetBundle.of(context)
        .loadString("resources/app_list.json");
    this.setState(() {
      data = json.decode(response);
    });
  }

  @override
  void initState() {
    super.initState();
    this.getData(context);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: GradientAppBar(
        title: Text('All Banned Apps'),
        backgroundColorStart: Colors.black,
        backgroundColorEnd: Color.fromRGBO(66, 66, 66, 1),
      ),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                leading: Image.asset(
                    "resources/images/" + data[index]['package'][0] + ".png"),
                title: Text(data[index]["name"]),
              ),
              Divider(height: 1.0),
            ],
          );
        },
      ),
    );
  }
}
