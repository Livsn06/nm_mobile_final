import 'dart:io';
import 'dart:typed_data';

class FormImageModel {
  int? id;
  String? name;
  File? file;
  Uint8List? bytes;

  FormImageModel({this.id, this.name, this.file, this.bytes});
}
