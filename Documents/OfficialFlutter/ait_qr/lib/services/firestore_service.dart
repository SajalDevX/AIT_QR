import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/qr_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addQR(QRModel qr) async {
    await _db.collection('smartlabs${qr.branch}').doc(qr.uid).set(qr.toMap());
  }

  Stream<List<QRModel>> getQRs(String branch) {
    return _db
        .collection('smartlabs$branch')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => QRModel.fromMap(doc.data(), doc.id))
            .toList());
  }

  Future<void> updateQR(
      String branch, String uid, Map<String, dynamic> data) async {
    await _db.collection('smartlabs$branch').doc(uid).update(data);
  }

  Future<void> deleteQR(String branch, String uid) async {
    await _db.collection('smartlabs$branch').doc(uid).delete();
  }
}
