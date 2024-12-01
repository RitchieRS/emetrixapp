import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vision/flutter_vision.dart';
import 'package:image/image.dart' as img;
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

class ObjectDetect extends StatefulWidget {
  const ObjectDetect({Key? key}) : super(key: key);

  @override
  State<ObjectDetect> createState() => _ObjectDetectState();
}

class _ObjectDetectState extends State<ObjectDetect> {
  late CameraController controller;
  CameraImage? cameraImage;
  bool isLoaded = false;
  late List<CameraDescription> cameras;
  File? _capturedImage;
  String resultMax = "";

  late FlutterVision vision;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    vision = FlutterVision();
    cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.high,
        imageFormatGroup: ImageFormatGroup.yuv420);
    controller.initialize().then((_) {
      controller.lockCaptureOrientation();
      loadYoloModel().then((_) {
        setState(() {
          isLoaded = true;
        });
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (!isLoaded) {
      return const Scaffold(
        body: Center(
          child: Text("Cargando..."),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Detección de Objetos"),
      ),
      body: Stack(
        children: [
          if (_capturedImage != null)
            Image.file(
              _capturedImage!,
              width: size.width,
              height: size.height * 0.845,
              fit: BoxFit.cover,
            )
          else
            Container(
              width: size.width,
              height: size.height * 0.845,
              child: CameraPreview(controller),
            ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: Container(
              width: size.width,
              height: size.height * 0.117,
              child: Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_capturedImage == null) {
                      await captureImage();
                    } else {
                      await analyzeCapturedImage();
                    }
                  },
                  child: Text(_capturedImage == null
                      ? "Tomar Foto"
                      : "Analizar Imagen"),
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
          useGpu: true);
      setState(() {
        isLoaded = true;
      });
    } catch (e) {
      print("Error al cargar el modelo: $e");
    }
  }

  Future<void> captureImage() async {
    final photo = await controller.takePicture();
    setState(() {
      _capturedImage = File(photo.path);
    });
  }

  Future<void> analyzeCapturedImage() async {
    if (_capturedImage == null) return;

    final Uint8List imageBytes = await _capturedImage!.readAsBytes();
    // Convertir la imagen capturada a una lista de bytes compatible con YUV420

    final result = await vision.yoloOnImage(
      bytesList: imageBytes,       // Lista de bytes de la imagen en formato YUV420
      imageHeight: 640, // Establece el tamaño de la imagen según el modelo
      imageWidth: 640,
      iouThreshold: 0.3,
      confThreshold: 0.3,
      classThreshold: 0.3,
    );

    if (result.isNotEmpty) {
      print(result);
      setState(() {
        resultMax = result.toString();
      });
    } else {
      setState(() {
        resultMax = "Sin resultados";
      });
    }
  }
    
}