import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: Text('About Us'),
        backgroundColorStart: Colors.black,
        backgroundColorEnd: Color.fromRGBO(66, 66, 66, 1),
      ),
      body: Center(
        child: Text('Bade log'),
      ),
    );
  }
}
