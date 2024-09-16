import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CustomQRWidget extends StatelessWidget {
  final String data;

  CustomQRWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    final qrCode = QrCode.fromData(
      data: data,
      errorCorrectLevel: QrErrorCorrectLevel.L,
    );

    return QrImage(qrCode) as Widget;
  }
}
