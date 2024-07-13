import 'dart:io';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageLoad extends StatefulWidget {
  final VoidCallback toggleTheme;
  const ImageLoad({Key? key, required this.toggleTheme}) : super(key: key);
  @override
  _ImageLoadState createState() => _ImageLoadState();
}

class _ImageLoadState extends State<ImageLoad> {
  File? _image;
  void _toggleLanguage() {
    if (context.locale == Locale('en', 'US')) {
      context.setLocale(Locale('tr', 'TR'));
    } else {
      context.setLocale(Locale('en', 'US'));
    }
  }

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('imagePath');
    if (imagePath != null) {
      setState(() {
        _image = File(imagePath);
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final name = pickedFile.name;
      final File newImage = await File(pickedFile.path).copy('${directory.path}/$name');

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('imagePath', newImage.path);

      setState(() {
        _image = newImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
           actions: [
          IconButton(
              onPressed: widget.toggleTheme,
              icon: const Icon(Icons.brightness_2_outlined),
          ),
          IconButton(
              onPressed: _toggleLanguage,
              icon: Icon(Icons.language),
          ),
          IconButton(
              onPressed: () {
              exit(0);
              },
              icon: const Icon(Icons.exit_to_app),
          ),
        ],
        title: Text('ImageLoadPage'.tr()),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null ? Text('No image selected.') : Image.file(_image!),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
          ],
        ),
      ),
    );
  }
}
