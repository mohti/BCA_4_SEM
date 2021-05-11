import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_compariosn/functions/functions.dart';

IconButton iconButton(double iconsize, IconData icon, Color color) {
  return IconButton(
      iconSize: iconsize, icon: Icon(icon, color: color), onPressed: () {});
}

Padding shareButton(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: Container(
      height: 50,
      width: 50,
      child: FloatingActionButton(
        onPressed: () {
          imagePaths.isEmpty ? print('No Image Selected') : onShare(context);
        },
        child: Icon(
          Icons.share_rounded,
          size: 26,
        ),
      ),
    ),
  );
}
