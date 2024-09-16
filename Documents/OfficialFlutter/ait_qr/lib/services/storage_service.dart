import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> uploadPDF(String branch, File file, String uid) async {
    try {
      Reference ref = _storage.ref().child('pdfs/$branch/$uid.pdf');
      UploadTask uploadTask = ref.putFile(file);
      TaskSnapshot snapshot = await uploadTask;
      String downloadURL = await snapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> deletePDF(String branch, String uid) async {
    try {
      Reference ref = _storage.ref().child('pdfs/$branch/$uid.pdf');
      await ref.delete();
    } catch (e) {
      print(e);
    }
  }
}
