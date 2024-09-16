import 'package:flutter/material.dart';
import '../models/qr_model.dart';
import '../services/qr_service.dart';

class QRListItem extends StatelessWidget {
  final QRModel qrModel;
  final Function onEdit;

  QRListItem({required this.qrModel, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    final QRService qrService = QRService();

    return ListTile(
      leading:
          qrService.generateQR(qrModel.fileURL), // Ensure this returns a Widget
      title: Text(qrModel.documentName),
      subtitle: Text('Date: ${qrModel.timestamp.toLocal().toString()}'),
      trailing: Text(qrModel.uid),
      onTap: () => onEdit(),
    );
  }
}
