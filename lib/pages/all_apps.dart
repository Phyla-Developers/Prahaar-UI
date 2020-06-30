// import 'dart:js';

// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:gradient_app_bar/gradient_app_bar.dart';

// class AllAppsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: GradientAppBar(
//         title: Text('Flutter'),
//         backgroundColorStart: Colors.black,
//         backgroundColorEnd: Color.fromRGBO(66, 66, 66, 1),
//       ),
//       body: ListView.builder(itemBuilder: null)
//     );
//   }

//   listGenerator(context) async {
//     var listOfApps = [];
//     String data = await DefaultAssetBundle.of(context)
//         .loadString("resources/app_list.json");
//     final jsonResult = json.decode(data);
//     for (var i = 0; i < jsonResult.length; i++) {
//       var currentApp = jsonResult[i];
//       var listTile = ListTile(
//           leading: Image.asset(
//               "resources/images/" + currentApp['package'][0] + ".png"),
//           title: Text(currentApp["name"]),
//           subtitle: Text(currentApp["package"].join(",")));
//       listOfApps.add(listTile);
//     }
//     return listOfApps;
//   }
// }
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
                  leading: Image.asset(
                      "resources/images/" + data[index]['package'][0] + ".png"),
                  title: Text(data[index]["name"]),
                  subtitle: Text(data[index]["package"].join(","))),
              Divider(height: 1.0),
            ],
          );
        },
      ),
    );
  }
}
