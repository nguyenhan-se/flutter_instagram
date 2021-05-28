import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:flutter_instagram/repositories/storage/base_storage_repository.dart';
import 'package:uuid/uuid.dart';

class StorageRepository extends BaseStorageRepository {
  final FirebaseStorage _firebaseStorage;

  StorageRepository({FirebaseStorage firebaseStorage})
      : _firebaseStorage = firebaseStorage ?? FirebaseStorage.instance;

  Future<String> _uploadImage(
      {@required File image, @required String ref}) async {
    return await _firebaseStorage
        .ref(ref)
        .putFile(image)
        .then((taskSnapshot) => taskSnapshot.ref.getDownloadURL());
  }

  @override
  Future<String> uploadPostImage({File image}) async {
    final imageId = Uuid().v4();

    final downloadUrl =
        await _uploadImage(image: image, ref: 'images/posts/post_$imageId.jpg');
    return downloadUrl;
  }

  @override
  Future<String> uploadProfileImage({String url, File image}) async {
    String imageId = Uuid().v4();
    print(
      'come here =====>$url',
    );
    if (url.isNotEmpty) {
      final exp = RegExp(r'userProfile_(.*).jpg');
      print(
        'exppp ==>$exp',
      );
      final abc = exp.firstMatch(url);
      print('abc====> $abc');
      imageId = exp.firstMatch(url)[1];
    }

    final downloadUrl = await _uploadImage(
        image: image, ref: 'images/users/userProfile_$imageId.jpg');

    return downloadUrl;
  }
}
