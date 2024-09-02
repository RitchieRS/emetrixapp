import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_vision/flutter_vision.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:ui' as ui;

class ObjectDetectApi extends StatefulWidget {
  const ObjectDetectApi({Key? key}) : super(key: key);

  @override
  State<ObjectDetectApi> createState() => _ObjectDetectState();
}

class _ObjectDetectState extends State<ObjectDetectApi> {
  late List<Map<String, dynamic>> yoloResults;
  bool isLoaded = false;
  File? _selectedImage;
  late FlutterVision vision;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    vision = FlutterVision();
    await loadYoloModel();
    setState(() {
      isLoaded = true;
      yoloResults = [];
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (!isLoaded) {
      return const Scaffold(
        body: Center(child: Text("Cargando...")),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Detección de Objetos"),
      ),
      body: Stack(
        children: [
          if (_selectedImage != null)
            Image.file(
              _selectedImage!,
              width: size.width,
              height: size.height * 0.845,
              fit: BoxFit.cover,
            ),
          ...displayBoxesAroundRecognizedObjects(size),
          Positioned(
            bottom: 0,
            width: size.width,
            child: Container(
              width: size.width,
              height: size.height * 0.117,
              child: Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: selectImage,
                      child: Text("Seleccionar Imagen"),
                    ),
                    if (_selectedImage != null)
                      ElevatedButton(
                        onPressed: analyzeImage,
                        child: Text("Analizar Imagen"),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> loadYoloModel() async {
    try {
      await vision.loadYoloModel(
        labels: 'assets/tflite/labels_detect.txt',
        modelPath: 'assets/tflite/model_detect.tflite',
        modelVersion: "yolov8",
        numThreads: 4,
        useGpu: true,
      );
      setState(() {
        isLoaded = true;
      });
    } catch (e) {
      print("Error al cargar el modelo: $e");
    }
  }

  Future<void> selectImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.gallery);

    if (photo != null) {
      setState(() {
        _selectedImage = File(photo.path);
        yoloResults.clear();
      });
    }
  }

  Future<void> analyzeImage() async {
    try {
      if (_selectedImage == null) return;

      final Uint8List imageBytes = await _selectedImage!.readAsBytes();

      final result = await vision.yoloOnImage(
        bytesList: imageBytes,
        imageHeight: 640, // Ajusta esto según sea necesario
        imageWidth: 640,
        iouThreshold: 0.3,
        confThreshold: 0.3,
        classThreshold: 0.3,
      );

      setState(() {
        yoloResults = result;
        print("Resultados Yolov8 ${yoloResults}");
      });
    } catch (e) {
      print("Error durante la detección: $e");
    }
  }

  List<Widget> displayBoxesAroundRecognizedObjects(Size screen) {
    if (yoloResults.isEmpty) return [];

    double screenWidth = screen.width;
    double screenHeight = screen.height * 0.845;

    return yoloResults.map((result) {
      final box = result["box"];
      //String label = result["tag"];

      String porcentaje = (box[4] * 100).toStringAsFixed(0);

      final int imageWidth = 720;
      final int imageHeight = 1280;

      double xRatio = screenWidth / imageWidth;
      double yRatio = screenHeight / imageHeight;

      double x1Image = box[0];
      double y1Image = box[1];
      double x2Image = box[2];
      double y2Image = box[3];

      print("Label****");
     // print(label);
      double x1Scaled = x1Image * xRatio;
      double y1Scaled = y1Image * yRatio;
      double x2Scaled = x2Image * xRatio;
      double y2Scaled = y2Image * yRatio;

      return Positioned(
        left: x1Image * (screen.width / 720),
        top: y1Image * (screen.width / 1280) + 100,
        width:
            (x2Image * (screen.width / 720)) - (x1Image * (screen.width / 720)),
        height: (y2Image * (screen.width / 1280)) -
            (y1Image * (screen.width / 1280)) +
            115,
        child: GestureDetector(
          onTap: () async {},
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    ),
                    color: Colors.blue),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    "Bottle",
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 13.0,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  border: Border.all(color: Colors.blue, width: 3.2),
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }
}