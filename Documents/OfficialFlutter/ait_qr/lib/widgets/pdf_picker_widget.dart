import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class PDFPickerWidget extends StatelessWidget {
  final VoidCallback onPick;

  PDFPickerWidget({required this.onPick});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf'],
        );
        if (result != null) {
          onPick();
        }
      },
      child: Text('Pick PDF File'),
    );
  }
}
