import 'package:flutter/material.dart';
import '../../services/firestore_service.dart';
import '../../models/qr_model.dart';
import '../../widgets/qr_list_item.dart';

class EditQRScreen extends StatefulWidget {
  final String branch;

  EditQRScreen({required this.branch});

  @override
  _EditQRScreenState createState() => _EditQRScreenState();
}

class _EditQRScreenState extends State<EditQRScreen> {
  late Stream<List<QRModel>> qrStream;

  final FirestoreService _firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    qrStream = _firestoreService.getQRs(widget.branch);
  }

  void _editQR(QRModel qrModel) async {
    // Here you can implement editing functionality
    // For example, navigate to an edit screen or show a dialog
    print('Editing QR: ${qrModel.id}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit QR Codes'),
      ),
      body: StreamBuilder<List<QRModel>>(
        stream: qrStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No QR codes available'));
          }

          final qrModels = snapshot.data!;

          return ListView.builder(
            itemCount: qrModels.length,
            itemBuilder: (context, index) {
              final qrModel = qrModels[index];
              return QRListItem(
                qrModel: qrModel,
                onEdit: () => _editQR(qrModel),
              );
            },
          );
        },
      ),
    );
  }
}
