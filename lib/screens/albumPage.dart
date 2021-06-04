import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_compariosn/controller/imageComparescreenController.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:transparent_image/transparent_image.dart';

import 'imageCompareScreen.dart';

class AlbumPage extends StatefulWidget {
  final Album album;

  AlbumPage(Album album) : album = album;

  @override
  State<StatefulWidget> createState() => AlbumPageState();
}

class AlbumPageState extends State<AlbumPage> {
  List<Medium> _media;

  @override
  void initState() {
    super.initState();
    initAsync();
  }

  void initAsync() async {
    MediaPage mediaPage = await widget.album.listMedia();
    setState(() {
      _media = mediaPage.items;
    });
  }

  //
  List<String> selectedIDList = [];
  List<Medium> selectedMediumList = [];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text("Select Photos"),
        ),
        body: Stack(
          children: [
            GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 5.0,
                crossAxisSpacing: 1.0,
                children: <Widget>[
                  ...?_media?.map((medium) => ShowImage(
                      medium: medium,
                      isSelected: (bool value) {
                        setState(() {
                          if (value) {
                            // print('selected');
                            selectedIDList.add(medium.id);
                            selectedMediumList.add(medium);
                          } else {
                            // print('unslected');
                            selectedIDList.remove(int.parse(medium.id));
                            selectedMediumList.remove(medium);
                          }
                        });
                        // print("${int.parse(medium.id)} : $value");
                      }))
                ]),
            selectedMediumList.length < 1
                ? Container()
                : Positioned(
                    bottom: 0,
                    child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width * 1,
                        child: ElevatedButton(
                            onPressed: () {
                              //ImageCompareScreenController(selectedIDList,selectedMediumList);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ImageCompare(
                                        selectedImageI: selectedIDList,
                                        selectedMediumLis: selectedMediumList,
                                      )));
                            },
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.check, size: 30),
                                  Text(' Proceed',
                                      style: TextStyle(
                                          fontFamily: 'Helvetica',
                                          fontSize: 22))
                                ]),
                            style: ElevatedButton.styleFrom(
                                primary: Theme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0))))))
          ],
        ),
      ),
    );
  }
}

class ShowImage extends StatefulWidget {
  final Medium medium;

  final ValueChanged<bool> isSelected;

  ShowImage({this.medium, this.isSelected});
  @override
  _ShowImageState createState() => _ShowImageState();
}

class _ShowImageState extends State<ShowImage> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          isSelected = !isSelected;
          widget.isSelected(isSelected);
        });

        // final File file =
        // await PhotoGallery.getFile(mediumId: medium.id);
        // selectedList.add(Item(file.path, int.parse(medium.id)));
        // print(selectedList);
        // Navigator.of(context).push(
        //   MaterialPageRoute(builder: (context) => ViewerPage(medium)),
        // );
      },
      child: Stack(
        children: [
          FadeInImage(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 1,
              fit: BoxFit.contain,
              placeholder: MemoryImage(kTransparentImage),
              image: ThumbnailProvider(
                  mediumId: widget.medium.id,
                  mediumType: widget.medium.mediumType,
                  highQuality: true)),
          isSelected
              ? Positioned(
                  top: 10,
                  right: 25,
                  // alignment: Alignment.bottomRight,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                          backgroundColor: Color.fromRGBO(255, 0, 0, 1.0),
                          child: Icon(Icons.check,
                              size: 30, color: Colors.white))))
              : Container()
        ],
      ),
    );
  }
}
