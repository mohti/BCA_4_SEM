import 'package:get/get.dart';
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
import 'package:get/get.dart';
//import 'imageViewer.dart';

class ImageCompareScreenController extends GetxController {
  List<String> selectedImageID;
  List<Medium> selectedMediumList;

  ImageCompareScreenController.two();

  ImageCompareScreenController(this.selectedImageID, this.selectedMediumList);

  removeafterdrag(int index) {
    selectedMediumList.removeAt(index);
    update();
  }
}
