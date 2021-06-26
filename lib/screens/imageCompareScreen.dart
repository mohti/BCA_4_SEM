import 'dart:io';
import 'dart:io' as Io;
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
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:image/image.dart';
// import 'package:gallery_saver/gallery_saver.dart';

List<String> favoriteImage = [];
List<Medium> deltedImages  = [];
List<Medium> Images  = [];

class ImageCompare extends StatefulWidget {
  List<String> selectedImageI;
  List<Medium> selectedMediumLis;
  List<Medium> backuplist;

  ImageCompare({
    @required this.selectedImageI, @required this.selectedMediumLis});
      @override
      _ImageCompareState createState() => _ImageCompareState();
  }

class _ImageCompareState extends State<ImageCompare> {

  bool accepted = false;
  List<String> selectedPathList = [];

  controllerInitializer() {
    final Image_CompareScreenController = Get.put(ImageCompareScreenController(
        widget.selectedImageI, widget.selectedMediumLis));
  }


  onShare(BuildContext context) async {
    if (favoriteImage.isNotEmpty) {
      await Share.shareFiles(
        favoriteImage,
      );
    }
  }

  // Future<File> _saveImage(String path ,Directory directory)async{
  //   try{
  //     File tempfile = File(path);
  //     final image = decodeImage(tempfile.readAsBytesSync());
  //     final thumbnail = copyResize(image, width: 512);
  //     String imgtype =path.split('.').last;
  //     if(imgtype=='jpg' ||imgtype=='jpeg'){
  //
  //     }else{
  //
  //     }
  //     File('thumbnail.png').writeAsBytesSync(encodePng(thumbnail));
  //   }catch(e){
  //
  //   }
  // }
  Future<void> saveImage() async{
           print('dir created ');
       Directory extDir = await getApplicationDocumentsDirectory();
      print('dir created ');
  }

  saveToGallery() async {
     Directory extDir = await getApplicationDocumentsDirectory();
    print('dir created ');
     // final filename = path.basename()
    // final String dirPath = '${extDir.path}/ImageCompare';
    // await Directory(dirPath).create(recursive: true);
    final folderName="imageCompare";
    final fpath= Directory("storage/emulated/0/$folderName");
    if ((await fpath.exists())){
       print("exist");
    }else{
      print("not exist");
      fpath.create();
    }
    if((await fpath.exists()))
     print(favoriteImage.length.toString());
         if(favoriteImage!=null) {
        for (int i = 0; i != favoriteImage.length; i++) {
          File saveimageFile = File(favoriteImage[i]);
          final filename = path.basename(saveimageFile.path);
          print(filename);
          final savedImage = await saveimageFile.copy('${fpath.path}/$filename');
          //final String filePath = '$dirPath${favoriteImage[0]}';
           //  final savedImage = await imageFile.copy('${appDir.path}/$fileName');

          //in this pictures will save in piture folder
          // final result = await ImageGallerySaver.saveFile(favoriteImage[0]);
          //print(result);


          //pub.add gallrysaver
          // GallerySaver.saveImage(favoriteImage[0],albumName: 'Ifav');
          // print(filePath);
      }
      Fluttertoast.showToast(
          msg: "Saved to Gallry",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      //  print(result);
      print('saveImagesuccess');
    }
    else{
      Fluttertoast.showToast(
        msg: "No Favorite Image Selected",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    }
  }

  //
  // _saveVideo() async {
  //   var appDocDir = await getTemporaryDirectory();
  //   String savePath = appDocDir.path + "/temp.mp4";
  //   await Dio().download("http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4", savePath);
  //   final result = await ImageGallerySaver.saveFile(savePath);
  //   print(result);
  // }


  @override
  void initState() {
    super.initState();
    print(widget.selectedImageI);
    controllerInitializer();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
     SystemChrome.setEnabledSystemUIOverlays([]);
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
   // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top,SystemUiOverlay.bottom]);
  }

  @override
  Widget build(BuildContext context) {
    double containerHeight = MediaQuery.of(context).size.height * 1.02;
    double containerWidth = MediaQuery.of(context).size.width * 0.08;
    return Scaffold(
      backgroundColor: Colors.black,
      body:Container(
        child: SafeArea(
          child: Row(
          children: [
            DropBox(false),
            DropBox(false),
            DropBox(false),
            GetBuilder<ImageCompareScreenController>(

                id:'listview',
                builder: (gxValues) {

              return Container(
                height: containerHeight,
                width: containerWidth,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Container(
                        height: 30,
                        width: containerWidth,
                        child: Stack(children: [
                          Positioned(
                              top: -10,
                              right: 20,
                              child: IconButton(
                                color: Colors.white,
                                icon: Icon(
                                  Icons.save,
                                  size: 20,
                                ),
                                onPressed: () => {
                                        if(deltedImages != null){
                                  print(deltedImages.toString()+'list of deleted  images'),
                                            for(int i=0;i<deltedImages.length;i++){
                                            if(gxValues.selectedMediumList.contains(deltedImages[i])){
                                              Fluttertoast.showToast(
                                                  msg: "Updated",
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0)
                                            }else
                                              {
                                                gxValues.selectedMediumList.add(
                                                    deltedImages[i]),
                                              gxValues.update(['listview'])
                                              }
                                }} else{
                                          Fluttertoast.showToast(
                                              msg: "Updated",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0)
                                        },
                                        gxValues.update(),
                                },
                              )),
                          Positioned(
                            top: -10,
                            right: -10,
                            child:favoriteImage.isEmpty ?
                            iconButton(
                                icon: Icons.favorite_border_rounded,
                                color: Colors.red,
                               // function: saveToGallery,
                                size: 20):
                            iconButton(
                                icon: Icons.favorite,
                                color: Colors.red,
                                function: saveToGallery,
                                size: 20),
                          ),
                        ]),
                      ),
                    ),
                    widget.selectedMediumLis != null
                        ? Container(
                            height: containerHeight - 48,
                            child: ListView.builder(
                              physics: ClampingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: gxValues.selectedMediumList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                    margin: EdgeInsets.symmetric(vertical: 4),
                                    child: DragBox(
                                        gxValues.selectedMediumList[index]));
                              },
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
              );
            }),
          ],
        ),),
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
    return Container(
      child: GetBuilder<ImageCompareScreenController>(builder: (gxValues) {
        return Draggable(
          affinity: Axis.horizontal,
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
        );
      }),
    );
  }
}

class DropBox extends StatefulWidget {
  bool accepted;
  DropBox(this.accepted);
  @override
  _DropBoxState createState() => _DropBoxState();
}

class _DropBoxState extends State<DropBox> {
  bool heartfilled = false;
  Medium imagePath;

  removeImage() async{
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
    if(deltedImages.contains(imagePath)){
      print('alredy exit');
    }else {
      deltedImages.add(imagePath);
      print(imagePath.toString());
      print(deltedImages.toString() + 'deleted images here');
    }
    // final File file = await PhotoGallery.getFile(mediumId: imagePath.id);
    // print(file.path);
    // d.add(file.path);
    setState(() {
      imagePath = null;
      heartfilled = false;
    });

  }
  removeToFavourite() async {
    if (imagePath != null) {
      final File file = await PhotoGallery.getFile(mediumId: imagePath.id);

      print(file.path);
      favoriteImage.remove(file.path);
      Fluttertoast.showToast(
          msg: "Remove from Favorite",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      setState(() {
        heartfilled = false;
      });
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
  addToFavourite() async {
    if (imagePath != null) {
      final File file = await PhotoGallery.getFile(mediumId: imagePath.id);
      print(file.path);
      if(favoriteImage.contains(file.path))
      {
        Fluttertoast.showToast(
            msg: "Already exists",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
      else {
        favoriteImage.add(file.path);
        Fluttertoast.showToast(
            msg: "Added to Favorite",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        setState(() {
          heartfilled = true;
        });
      }
    }
    else {
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

  @override
  Widget build(BuildContext context) {
    double containerHeight = MediaQuery.of(context).size.height * 1;
    double containerWidth = MediaQuery.of(context).size.width * 0.30;
    return Container(
      child: GetBuilder<ImageCompareScreenController>(builder: (gxValues) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: DragTarget(
            onAccept: (Medium string1) async{
              if(imagePath != null){
                if(!gxValues.selectedMediumList.contains(imagePath))
                gxValues.selectedMediumList.add(imagePath);
                gxValues.update(['listview']);
              }else{
              }
              imagePath = string1;
              widget.accepted = true;
              gxValues.selectedMediumList.remove(string1);
              gxValues.update(['listview']);
              if(!deltedImages.contains(string1)) {
                deltedImages.add(string1);
              }else
                {
                }
              gxValues.update(['listview']);
              final File file = await PhotoGallery.getFile(mediumId: imagePath.id);
              if(favoriteImage.contains(file.path)){
                heartfilled=true;
                print('mohit it contain');
               gxValues.update();
              }else{
                heartfilled = false;
                gxValues.update();
                print('mohit it dont contain');
              }
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
                                      builder: (context) =>
                                          ViewerPage(imagePath)),
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
                          :imagePath==null ?Text(
                              'Drag and Drop Images Here',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )
                          :
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    ViewerPage(imagePath)),
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
                    ),
                    Positioned(
                      bottom: 0,
                      left: containerWidth / 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          iconButton(
                              icon: Icons.clear,
                              color: Colors.white,
                              function: removeImage,
                              size: 30),
                          SizedBox(width: 30),
                          heartfilled && accepted.isEmpty && imagePath!= null
                              ?
                               iconButton(
                                  color: Colors.red,
                                  function: removeToFavourite,
                                  icon: Icons.favorite,
                                  size: 30)
                                // gxValues.update(),
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
      }),
    );
  }
}

//
// final File file = await PhotoGallery.getFile(mediumId: imagePath.id);
// if(favoriteImage == file.path)
// {
//
// }
// else {
// favoriteImage.add(file.path);
// }
