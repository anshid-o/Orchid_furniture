import 'package:flutter/material.dart';
import 'package:orchid_furniture/constants.dart';

class ImageViewPage extends StatelessWidget {
  final String imageUrl;
  final String heroTag;

  ImageViewPage({required this.imageUrl, required this.heroTag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightWoodcol,
      appBar: AppBar(
        backgroundColor: lightWoodcol,
        title: Text('Product Image'),
      ),
      body: Center(
        child: Hero(
          tag: heroTag,
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ),
    );
  }
}
