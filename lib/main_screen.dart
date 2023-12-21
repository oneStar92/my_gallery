import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final ImagePicker _picker = ImagePicker();
  List<XFile>? images;

  @override
  void initState() {
    super.initState();
    loadImages();
  }

  Future<void> loadImages() async {
    images = await _picker.pickMultiImage();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('전자액자'),
      ),
      body: images == null
          ? const Center(
              child: Text('No data'),
            )
          : FutureBuilder<Uint8List>(
              future: images![0].readAsBytes(),
              builder: (context, snapshot) {
                final data = snapshot.data;
                if (data == null || snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Image.memory(
                  data,
                  width: double.infinity,
                  fit: BoxFit.cover,
                );
              },
            ),
    );
  }
}
