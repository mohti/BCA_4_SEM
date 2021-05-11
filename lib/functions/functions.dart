import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:ui' as ui;
import 'package:share/share.dart';

// save to gallery
GlobalKey _globalKey = GlobalKey();
saveScreen() async {
  RenderRepaintBoundary boundary =
      _globalKey.currentContext.findRenderObject() as RenderRepaintBoundary;
  ui.Image image = await boundary.toImage();
  ByteData byteData = await (image.toByteData(format: ui.ImageByteFormat.png));
  if (byteData != null) {
    final result =
        await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
    print(result);
  }
}

// add to favorite
List<String> imagePaths = [];

onShare(BuildContext context) async {
  if (imagePaths.isNotEmpty) {
    await Share.shareFiles(
      imagePaths,
    );
  }
}
