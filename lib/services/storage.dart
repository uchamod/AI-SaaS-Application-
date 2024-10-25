import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageServices {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  //upload image
  Future<String> uploadImage(
      {required File imageFile, required String userId}) async {
    Reference reference = _firebaseStorage
        .ref()
        .child("Images")
        .child("${userId}/${DateTime.now()}");
    try {
      UploadTask uploadTask = reference.putFile(imageFile , SettableMetadata(
          contentType: 'image/jpeg',
        ),);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downlodableUrl = await taskSnapshot.ref.getDownloadURL();
      return downlodableUrl;
    } catch (err) {
      print("image uploding error$err");
      Exception("upload not succssufuly");
      return "";
    }
  }
}
