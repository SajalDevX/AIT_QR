import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../../services/storage_service.dart';
import '../../services/firestore_service.dart';
import '../../models/qr_model.dart';

class CreateQRScreen extends StatefulWidget {
  final String branch;

  CreateQRScreen({required this.branch});

  @override
  _CreateQRScreenState createState() => _CreateQRScreenState();
}

class _CreateQRScreenState extends State<CreateQRScreen> {
  final _formKey = GlobalKey<FormState>();
  late String documentName;
  late String fileURL;
  late File file;

  final StorageService _storageService = StorageService();
  final FirestoreService _firestoreService = FirestoreService();

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);

    if (result != null) {
      setState(() {
        file = File(result.files.single.path!);
      });
    }
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Upload PDF and get URL
      fileURL = await _storageService.uploadPDF(
              widget.branch, file, DateTime.now().toString()) ??
          '';

      // Create QR model
      QRModel qrModel = QRModel(
        id: DateTime.now().toString(),
        branch: widget.branch,
        documentName: documentName,
        uid: DateTime.now().toString(),
        fileURL: fileURL,
        timestamp: DateTime.now(),
      );

      // Save QR model to Firestore
      await _firestoreService.addQR(qrModel);

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('QR Code created successfully')));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create QR Code'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Document Name'),
                onSaved: (value) => documentName = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter document name' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickFile,
                child: Text('Pick PDF File'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
