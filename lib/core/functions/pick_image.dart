import 'dart:io';

import 'package:file_picker/file_picker.dart';

Future<File?> pickImage() async {
  try {
    final image = await FilePicker.platform.pickFiles(type: FileType.image);
    return image != null ? File(image.files.single.path!) : null;
  } on Exception {
    return null;
  }
}
