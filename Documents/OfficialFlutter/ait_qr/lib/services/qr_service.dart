import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRService {
  Widget generateQR(String data, {double size = 200.0}) {
    final qrCode = QrCode.fromData(
      data: data,
      errorCorrectLevel: QrErrorCorrectLevel.L,
    );

    return QrImage(qrCode) as Widget;
  }
}
