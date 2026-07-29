import 'dart:io';

import 'package:file_picker/file_picker.dart';

Future<File?> pickSong() async {
  try {
    final song = await FilePicker.platform.pickFiles(type: FileType.audio);
    return song != null ? File(song.files.single.path!) : null;
  } on Exception {
    return null;
  }
}
