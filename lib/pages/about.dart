import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  final bodyTextStyle = TextStyle();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: Text('About Us'),
        backgroundColorStart: Colors.black,
        backgroundColorEnd: Color.fromRGBO(66, 66, 66, 1),
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.all(50),
          color: Colors.black,
          child: Center(
            child: Container(
              padding: EdgeInsets.all(50),
              decoration: BoxDecoration(color: Colors.white),
              child: Linkify(
                  text:
                      "Phyla is a developer's group who are enthusiastic about technologies and solutions for real life challenges. We at Phyla strongly care about values and rights of all individuals.\nYou can reach us at: dev.phyla@gmail.com for any queries or suggestions",
                  onOpen: _onOpen,
                  linkStyle: TextStyle(color: Colors.lightBlue[600])),
            ),
          )),
    );
  }
}

Future<void> _onOpen(LinkableElement link) async {
  if (await canLaunch(link.url)) {
    await launch(link.url);
  } else {
    throw 'Could not launch $link';
  }
}
