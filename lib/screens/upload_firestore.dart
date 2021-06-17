import 'package:flutter/material.dart';
import 'firestore_data.dart';
import 'package:firebase_core/firebase_core.dart';

class UploadScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UploadFirestore(),
    );
  }
}
