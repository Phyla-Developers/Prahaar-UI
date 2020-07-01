import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:http/http.dart' as http;

class SocialScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GradientAppBar(
          title: Text('Share'),
          backgroundColorStart: Colors.black,
          backgroundColorEnd: Color.fromRGBO(66, 66, 66, 1),
        ),
        body: Example01(),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(vertical: 30),
          height: 100,
          child: Text(
            "Share our love for India",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Bebas',
              fontWeight: FontWeight.w700,
              fontSize: 30,
            ),
            textAlign: TextAlign.center,
          ),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black,
              )
            ],
            color: Colors.black,
          ),
        ));
  }
}

List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(2, 2),
];
List<Widget> _tiles = const <Widget>[
  const _Example01Tile(
      "resources/posters/poster_1.jpeg", "Poster 1", Colors.white),
  const _Example01Tile(
      "resources/posters/poster_2.jpeg", "Poster 2", Colors.white),
  const _Example01Tile(
      "resources/posters/poster_3.jpeg", "Poster 3", Colors.white),
  const _Example01Tile(
      "resources/posters/poster_4.jpeg", "Poster 4", Colors.black),
  const _Example01Tile(
      "resources/posters/poster_5.jpeg", "Poster 5", Colors.black),
  const _Example01Tile(
      "resources/posters/poster_8.jpeg", "Poster 8", Colors.black),
  const _Example01Tile(
      "resources/posters/poster_10.jpeg", "Poster 10", Colors.black)
];

class Example01 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: BoxDecoration(color: Colors.black),
      child: new StaggeredGridView.count(
        crossAxisCount: 4,
        staggeredTiles: _staggeredTiles,
        children: _tiles,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        padding: const EdgeInsets.all(4.0),
      ),
    );
  }
}

class _Example01Tile extends StatelessWidget {
  const _Example01Tile(this.imagePath, this.name, this.color);
  final String imagePath;
  final String name;
  final Color color;
  @override
  Widget build(BuildContext context) {
    final Image loadedImage = Image.asset(this.imagePath);
    return Card(
        color: this.color,
        child: InkWell(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: loadedImage,
            ),
          ),
          onTap: () => _shareImage(this.imagePath),
        ));
  }
}

Future<void> _shareImage(String path) async {
  try {
    final ByteData bytes = await rootBundle.load(path);
    final response = await http.get(
        'https://raw.githubusercontent.com/Phyla-Developers/Prahaar/master/project_link');
    final appLink = response.body;
    await Share.file(
        'esys image', 'esys.png', bytes.buffer.asUint8List(), 'image/jpeg',
        text: '59 Ways To Become Aatmanirbhar #Prahar\nDownload from $appLink');
  } catch (e) {
    print('error: $e');
  }
}
