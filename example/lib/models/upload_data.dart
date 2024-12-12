import 'dart:typed_data';
import 'dart:io';

//# This model for storing multiple images
class FormImageModel {
  int? id;
  String? name;
  File? file;
  Uint8List? bytes;

  FormImageModel({
    this.id,
    this.name,
    this.file,
    this.bytes,
  });
}
