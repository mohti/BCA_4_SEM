import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:transparent_image/transparent_image.dart';

//image viewer
class ViewerPage extends StatelessWidget {
  final Medium medium;

  ViewerPage(Medium medium) : medium = medium;

  @override
  Widget build(BuildContext context) {
    DateTime date = medium.creationDate ?? medium.modifiedDate;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        // appBar: AppBar(
        //   backgroundColor: Theme.of(context).primaryColor,
        //   // leading: IconButton(
        //   //   onPressed: () => Navigator.of(context).pop(),
        //   //   icon: Icon(Icons.arrow_back_ios),
        //   // ),
        //   // title: date != null ? Text(date.toLocal().toString()) : null,
        // ),
        body: Container(
          alignment: Alignment.center,
          child: medium.mediumType == MediumType.image
              ? FadeInImage(
                  fit: BoxFit.cover,
                  placeholder: MemoryImage(kTransparentImage),
                  image: PhotoProvider(mediumId: medium.id),
                )
              : Container(
                  child: Center(
                    child: Text('Video Not Supported'),
                  ),
                ),
        ),
      ),
    );
  }
}
