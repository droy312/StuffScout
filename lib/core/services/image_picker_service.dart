import 'dart:io';

import 'package:image_picker/image_picker.dart';

import '../../service_locator.dart';

class ImagePickerService {
  final ImagePicker _imagePicker = sl<ImagePicker>();

  Future<File?> getImageFileFromCamera() async {
    final XFile? xfile =
        await _imagePicker.pickImage(source: ImageSource.camera);

    return xfile != null ? File(xfile.path) : null;
  }

  Future<File?> getImageFileFromGallery() async {
    final XFile? xfile =
    await _imagePicker.pickImage(source: ImageSource.gallery);

    return xfile != null ? File(xfile.path) : null;
  }
}
