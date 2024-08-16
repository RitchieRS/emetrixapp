import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class ObjectDetectApi extends ConsumerStatefulWidget {
  const ObjectDetectApi({Key? key}) : super(key: key);

  @override
  _ObjectDetectApiState createState() => _ObjectDetectApiState();
}

class _ObjectDetectApiState extends ConsumerState<ObjectDetectApi> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _openCamera() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _sendImageToApi() async {
    if (_imageFile != null) {
      final uri = Uri.parse("http://54.202.132.137/scanImgApp"); // Cambia esta URL a tu endpoint
      var request = http.MultipartRequest('POST', uri)
        ..files.add(await http.MultipartFile.fromPath('image', _imageFile!.path));

      var response = await request.send();

      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ResultPage(response: 'Image uploaded successfully!')),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ResultPage(response: 'Failed to upload image!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera Capture'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_imageFile != null)
            Image.file(_imageFile!)
          else
            Text('No image captured.'),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _openCamera,
            child: Text('Capture Image'),
          ),
          if (_imageFile != null)
            ElevatedButton(
              onPressed: _sendImageToApi,
              child: Text('Send Image to API'),
            ),
        ],
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  final String response;

  const ResultPage({Key? key, required this.response}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
      ),
      body: Center(
        child: Text(response),
      ),
    );
  }
}