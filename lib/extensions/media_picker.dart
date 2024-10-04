import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:music_app/constant/import.dart';

class MediaPicker {
  static Future<File?> openGallery() async {
    try {
      var pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );
      if (pickedFile != null) {
        var image = File(pickedFile.path);
        return image;
      }
    } catch (e) {
      AppLogs.debugPrint("openGallery = == ${e.toString()}");
    }

    return null;
  }

  static Future<File?> openCamera() async {
    try {
      var pickedFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );
      if (pickedFile != null) {
        var image = File(pickedFile.path);
        return image;
      }
    } catch (e) {
      AppLogs.debugPrint("openGallery = == ${e.toString()}");
    }

    return null;
  }
}
