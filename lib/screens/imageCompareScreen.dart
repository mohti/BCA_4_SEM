import 'dart:io';
import 'package:image_compariosn/controller/imageComparescreenController.dart';
import 'package:images_picker/images_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:share/share.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_compariosn/widgets/widgets.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:get/get.dart';
import 'imageViewer.dart';

List<String> favoriteImage = [];
  // List<String> selectedImageID;
  // List<Medium> selectedMediumList;

class ImageCompare extends StatefulWidget {
  // final List<String> selectedImageID;
  // final List<Medium> selectedMediumList;
  List<String> selectedImageI;
  List<Medium> selectedMediumLis;
   //ImageCompare('hg');
  ImageCompare(
      {@required this.selectedImageI, @required this.selectedMediumLis});
  @override
  _ImageCompareState createState() => _ImageCompareState();
}

class _ImageCompareState extends State<ImageCompare> {
hello() {
  final Image_CompareScreenController = Get.put(ImageCompareScreenController(
      widget.selectedImageI, widget.selectedMediumLis));
}
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
    print(widget.selectedImageI);
 hello();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
  }

  @override
  Widget build(BuildContext context) {
    double containerHeight = MediaQuery
        .of(context)
        .size
        .height * 1.02;
    double containerWidth = MediaQuery
        .of(context)
        .size
        .width * 0.08;
    return
     Scaffold(
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
          GetBuilder<ImageCompareScreenController>(builder: (gxValues) {
            return Container(
            //height: containerHeight,
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
              gxValues.selectedImageID != null
                    ? Container(
                     height: containerHeight,
                      child: ListView.builder(
                      physics: ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: gxValues.selectedImageID.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 4),
                          //mohit from here we buid
                          child:
                          DragBox(gxValues.selectedMediumList[index])
                            );
                    },
                  ),
                )
                    : SizedBox(),
              ],
            ),
          );}),
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
  ///final int index;

  DragBox(this.image);
  @override
  _DragBoxState createState() => _DragBoxState();
}

class _DragBoxState extends State<DragBox> {
  removeafterdrag(String index){
    ImageCompareScreenController.two().selectedMediumList.removeLast();
  }
  @override
  Widget build(BuildContext context) {
      return Container (
          child:GetBuilder<ImageCompareScreenController>(builder: (gxValues) {
           return  Draggable(
              affinity:Axis.horizontal,
             data: widget.image,
              child: Container(
                 child: FadeInImage(
                    placeholder: MemoryImage(kTransparentImage),
                    image: ThumbnailProvider(
                           mediumId: widget.image.id,
                        mediumType: widget.image.mediumType,
                        highQuality: false)),
             
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
            //delay: Duration(milliseconds: 50),
           );
          }),);
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
  //selectedImageID
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
    return Container (
    child:
      GetBuilder<ImageCompareScreenController>(builder: (gxValues) {
       return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: DragTarget(
          onAccept: (Medium string1) {
            imagePath = string1;
            setState(() {
            widget.accepted = true;
            gxValues.selectedMediumList.remove(string1);
            gxValues.update();
          }
          );
          //selectedMediumList[index]
         // widget.selectedMediumList[index]
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
                                  highQuality: true)
                            // ImageCompareScreenController.two().selectedMediumList.removeLast(),
                        ),


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
    ); }),);
  }
}
