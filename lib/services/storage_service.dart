import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart ' as firebase_storage;

import 'package:image_picker/image_picker.dart';

class StorageService {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> uploadImage(XFile image) async {
    await storage.ref('product_images/${image.path}').putFile(File(image.path));
  }

  Future<String> getDownloadURL(String imageName) async {
    String downloadURL = await storage
        .ref('product_images/data/user/0/com.example.dhur/cache/$imageName')
        .getDownloadURL();
    return downloadURL;
  }
}
