import 'dart:io';
import 'package:images_picker/images_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:share/share.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_compariosn/widgets/widgets.dart';
import 'package:transparent_image/transparent_image.dart';

import 'imageViewer.dart';

List<String> favoriteImage = [];

class ImageCompare extends StatefulWidget {
  final List<String> selectedImageID;
  final List<Medium> selectedMediumList;

  ImageCompare(
      {@required this.selectedImageID, @required this.selectedMediumList});
  @override
  _ImageCompareState createState() => _ImageCompareState();
}

class _ImageCompareState extends State<ImageCompare> {
  // conts
  bool accepted = false;

  List<String> selectedPathList = [];

  onShare(BuildContext context) async {
    if (favoriteImage.isNotEmpty) {
      await Share.shareFiles(
        favoriteImage,
      );
    }
  }

  saveToGallery() async {
    for (var i = 0; i == favoriteImage.length; i++) {
      bool status = await ImagesPicker.saveImageToAlbum(File(favoriteImage[i]));
      print(status.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    print(widget.selectedImageID);

    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
  }

  @override
  Widget build(BuildContext context) {
    double containerHeight = MediaQuery.of(context).size.height * 0.89;
    double containerWidth = MediaQuery.of(context).size.width * 0.08;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          DropBox(false),
          DropBox(false),
          DropBox(false),
          // Container(
          //   height: containerHeight,
          //   width: containerWidth,
          //   color: Colors.deepOrange,
          //   child: ReorderableList,
          // ),
          Container(
            height: containerHeight,
            width: containerWidth,
            child: Stack(
              children: [
                Positioned(
                  top: -10,
                  right: 20,
                  child: iconButton(
                      color: Colors.red,
                      function: null,
                      icon: Icons.favorite,
                      size: 20),
                ),
                Positioned(
                  top: -10,
                  right: -10,
                  child: iconButton(
                      icon: Icons.save,
                      color: Colors.white,
                      function: saveToGallery,
                      size: 20),
                ),
                widget.selectedImageID != null
                    ? SizedBox(
                        height: containerHeight,
                        child: ListView.builder(
                          physics: ClampingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: widget.selectedImageID.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                                margin: EdgeInsets.symmetric(vertical: 4),
                                child:
                                    DragBox(widget.selectedMediumList[index]));
                          },
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: shareButton(context),
    );
  }

  Padding shareButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        height: 50,
        width: 50,
        child: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            favoriteImage.isEmpty
                ? Fluttertoast.showToast(
                    msg: "No Favorite Image Selected",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0)
                : onShare(context);
          },
          child: Icon(Icons.share_rounded, size: 26),
        ),
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }
}

class DragBox extends StatefulWidget {
  final Medium image;

  DragBox(this.image);
  @override
  _DragBoxState createState() => _DragBoxState();
}

class _DragBoxState extends State<DragBox> {
  @override
  Widget build(BuildContext context) {
    return Draggable(
      axis: Axis.horizontal,
      data: widget.image,
      child: Container(
        // width: 200,
        // height: 200,
        child: FadeInImage(
            placeholder: MemoryImage(kTransparentImage),
            image: ThumbnailProvider(
                mediumId: widget.image.id,
                mediumType: widget.image.mediumType,
                highQuality: true)),
      ),
      feedback: Container(
        width: 100,
        height: 100,
        child: FadeInImage(
            placeholder: MemoryImage(kTransparentImage),
            image: ThumbnailProvider(
                mediumId: widget.image.id,
                mediumType: widget.image.mediumType,
                highQuality: true)),
      ),
    );
  }
}

// ignore: must_be_immutable
class DropBox extends StatefulWidget {
  bool accepted;
  DropBox(this.accepted);
  @override
  _DropBoxState createState() => _DropBoxState();
}

class _DropBoxState extends State<DropBox> {
  removeImage() {
    if (imagePath != null) {
      Fluttertoast.showToast(
          msg: "Removed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    setState(() {
      imagePath = null;
    });
  }

  addToFavourite() async {
    if (imagePath != null) {
      final File file = await PhotoGallery.getFile(mediumId: imagePath.id);
      print(file.path);
      favoriteImage.add(file.path);
      Fluttertoast.showToast(
          msg: "Added to Favorite",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "No Image Selected",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    print(favoriteImage);
  }

  Medium imagePath;
  @override
  Widget build(BuildContext context) {
    double containerHeight = MediaQuery.of(context).size.height * 1;
    double containerWidth = MediaQuery.of(context).size.width * 0.30;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: DragTarget(
        onAccept: (Medium string1) {
          imagePath = string1;
          setState(() {
            widget.accepted = true;
          });
        },
        builder: (
          BuildContext context,
          List<dynamic> accepted,
          List<dynamic> rejected,
        ) {
          return Container(
            padding: EdgeInsets.all(2),
            height: containerHeight,
            width: containerWidth,
            decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(width: 1, color: Colors.white)),
            child: Stack(
              children: [
                Center(
                  child: accepted.isEmpty && imagePath != null
                      ? InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => ViewerPage(imagePath)),
                            );
                          },
                          child: FadeInImage(
                              fit: BoxFit.fitHeight,
                              placeholder: MemoryImage(kTransparentImage),
                              image: ThumbnailProvider(
                                  mediumId: imagePath.id,
                                  mediumType: imagePath.mediumType,
                                  highQuality: true)),
                        )
                      : Text(
                          'Drag and Drop Images Here',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                ),
                Positioned(
                  bottom: 0,
                  left: containerWidth / 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      iconButton(
                          icon: Icons.highlight_remove_rounded,
                          color: Colors.white,
                          function: removeImage,
                          size: 30),
                      SizedBox(width: 30),
                      favoriteImage.length > 1 && imagePath != null
                          ? iconButton(
                              color: Colors.red,
                              function: addToFavourite,
                              icon: Icons.favorite,
                              size: 30)
                          : iconButton(
                              color: Colors.red,
                              function: addToFavourite,
                              icon: Icons.favorite_border_rounded,
                              size: 30),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
