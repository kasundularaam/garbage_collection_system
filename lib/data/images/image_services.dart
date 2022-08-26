import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class ImageServices {
  static Future<File> renamedImage(
      {required String fileName, required ImageSource imageSource}) async {
    try {
      ImagePicker picker = ImagePicker();
      XFile? xImage = await picker.pickImage(
        source: imageSource,
        preferredCameraDevice: CameraDevice.front,
      );
      if (xImage != null) {
        File image = File(xImage.path);
        String dir = (await getApplicationDocumentsDirectory()).path;
        String newPath = path.join(dir, '$fileName.jpeg');
        File newImage = await File(image.path).copy(newPath);
        return newImage;
      } else {
        throw "image_error".tr();
      }
    } catch (e) {
      throw "error".tr();
    }
  }

  static Future<File> camImage() async {
    try {
      ImagePicker picker = ImagePicker();
      XFile? xImage = await picker.pickImage(
        source: ImageSource.camera,
      );
      if (xImage != null) {
        return File(xImage.path);
      } else {
        throw "image_error".tr();
      }
    } catch (e) {
      throw "error".tr();
    }
  }

  static Future<File> galleryImage() async {
    try {
      ImagePicker picker = ImagePicker();
      XFile? xImage = await picker.pickImage(
        source: ImageSource.gallery,
      );
      if (xImage != null) {
        return File(xImage.path);
      } else {
        throw "image_error".tr();
      }
    } catch (e) {
      throw "error".tr();
    }
  }
}
