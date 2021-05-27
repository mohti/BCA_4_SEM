import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter/rendering.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:permission_handler/permission_handler.dart';

import 'albumPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Album> _albums;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loading = true;
    initAsync();
  }

  Future<void> initAsync() async {
    if (await _promptPermissionSetting()) {
      List<Album> albums =
          await PhotoGallery.listAlbums(mediumType: MediumType.image);
      setState(() {
        _albums = albums;
        _loading = false;
      });
    }
    setState(() {
      _loading = false;
    });
  }

  Future<bool> _promptPermissionSetting() async {
    if (Platform.isIOS &&
            await Permission.storage.request().isGranted &&
            await Permission.photos.request().isGranted ||
        Platform.isAndroid && await Permission.storage.request().isGranted) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Color.fromRGBO(255, 0, 0, 1.0)),
      home: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const Text('iFavorite Pro',
                style: TextStyle(fontSize: 26, fontFamily: 'Helvetica')),
            actions: [
              IconButton(
                  icon: Icon(Icons.share, size: 30, color: Colors.white),
                  onPressed: null)
            ]),
        body: _loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : LayoutBuilder(
                builder: (context, constraints) {
                  double gridWidth = (constraints.maxWidth - 20) / 2;
                  double gridHeight = gridWidth + 40;
                  double ratio = gridWidth / gridHeight;
                  return Container(
                    padding: EdgeInsets.all(5),
                    child: GridView.count(
                      childAspectRatio: ratio,
                      crossAxisCount: 2,
                      mainAxisSpacing: 5.0,
                      crossAxisSpacing: 5.0,
                      children: <Widget>[
                        ...?_albums?.map(
                          (album) => GestureDetector(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => AlbumPage(album))),
                            child: Column(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: Container(
                                    color: Colors.grey[300],
                                    height: gridWidth,
                                    width: gridWidth,
                                    child: FadeInImage(
                                      fit: BoxFit.cover,
                                      placeholder:
                                          MemoryImage(kTransparentImage),
                                      image: AlbumThumbnailProvider(
                                        albumId: album.id,
                                        mediumType: album.mediumType,
                                        highQuality: true,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(left: 2.0),
                                  child: Text(
                                    album.name,
                                    maxLines: 1,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontFamily: 'Helvetica',
                                        height: 1.2,
                                        fontSize: 20),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(left: 2.0),
                                  child: Text(
                                    album.count.toString(),
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontFamily: 'Helvetica',
                                        height: 1.2,
                                        fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
