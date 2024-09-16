import 'package:cloud_firestore/cloud_firestore.dart';

class QRModel {
  final String id;
  final String branch;
  final String documentName;
  final String uid;
  final String fileURL;
  final DateTime timestamp;

  QRModel({
    required this.id,
    required this.branch,
    required this.documentName,
    required this.uid,
    required this.fileURL,
    required this.timestamp,
  });

  factory QRModel.fromMap(Map<String, dynamic> data, String documentId) {
    return QRModel(
      id: documentId,
      branch: data['branch'],
      documentName: data['documentName'],
      uid: data['uid'],
      fileURL: data['fileURL'],
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'branch': branch,
      'documentName': documentName,
      'uid': uid,
      'fileURL': fileURL,
      'timestamp': timestamp,
    };
  }
}
