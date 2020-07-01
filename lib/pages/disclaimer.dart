import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

class DisclaimerScreen extends StatelessWidget {
  final bodyTextStyle = TextStyle();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: Text('Disclaimer'),
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
                      "Disclaimer:\n1. This app lists the banned apps by the Government of India.\n2. We do not intend to do any kind of harm to listed apps by any means.\n3. The uninstall app feature is provided as an assistant to help the users comply with the recent Government rules.\n4. We take permission from the user before uninstalling the apps listed. And the user is solely responsible for the removal of the app from the device.\n5. No data (personal/public/anonymous) is collected from the user using this app.\n6. The official list for banned apps has been referred from https://pib.gov.in/PressReleseDetailm.aspx?PRID=1635206",
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
