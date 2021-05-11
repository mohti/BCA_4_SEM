import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_compariosn/widgets/widgets.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class ImageCompare extends StatefulWidget {
  @override
  _ImageCompareState createState() => _ImageCompareState();
}

class _ImageCompareState extends State<ImageCompare> {
  // conts
  double containerHeight = 0.9;
  double containerWidth = 0.24;
  bool accepted = false;

  //pick images
  // ignore: unused_field
  String _error = 'No Error Dectected';

  List<Asset> images = <Asset>[];

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 1000,
        enableCamera: true,
        selectedAssets: images,
      );
    } on Exception catch (e) {
      error = e.toString();
    }
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
  }

  @override
  void initState() {
    super.initState();
    loadAssets();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            dragableImageDisplay(),
            Container(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width * 0.2,
              child: Column(
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        iconButton(30, Icons.favorite, Colors.red),
                        iconButton(30, Icons.save, Colors.white),
                      ]),
                  Expanded(child: buildGridView()),
                ],
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: shareButton(context),
      ),
    );
  }

  // showo images
  Widget buildGridView() {
    return GridView.count(
      scrollDirection: Axis.vertical,
      crossAxisCount: 1,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return Draggable<Asset>(
          feedback: Container(
            margin: EdgeInsets.all(6),
            child: AssetThumb(
              asset: asset,
              width: 300,
              height: 300,
            ),
          ),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: AssetThumb(
              asset: asset,
              width: 300,
              height: 300,
            ),
          ),
        );
      }),
    );
  }

  DragTarget<Asset> dragableImageDisplay() {
    return DragTarget<Asset>(
      builder: (context, data, rejectedData) {
        return Container(
            child: Center(
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: accepted == false
                      ? Text(
                          "Drag and drop images here",
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        )
                      : Container()),
            ),
            margin: EdgeInsets.symmetric(horizontal: 4),
            height: MediaQuery.of(context).size.height * containerHeight,
            width: MediaQuery.of(context).size.width * containerWidth,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.white)));
      },
      onWillAccept: (images) {
        return true;
      },
      onAccept: (images) {
        setState(() {
          accepted = true;
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown]);
  }
}
