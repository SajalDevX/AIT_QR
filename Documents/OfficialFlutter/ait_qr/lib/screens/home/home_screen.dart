import 'package:flutter/material.dart';
import 'create_qr_screen.dart';
import 'scan_qr_screen.dart';
import 'edit_qr_screen.dart';

class HomeScreen extends StatelessWidget {
  final String branch;

  HomeScreen({required this.branch});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home - $branch'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/auth');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CreateQRScreen(branch: branch),
                  ),
                );
              },
              child: Text('Create QR Code'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ScanQRScreen(),
                  ),
                );
              },
              child: Text('Scan QR Code'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EditQRScreen(branch: branch),
                  ),
                );
              },
              child: Text('Edit QR Codes'),
            ),
          ],
        ),
      ),
    );
  }
}
