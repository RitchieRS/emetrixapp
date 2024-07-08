import 'dart:async';
import 'dart:io';
import 'dart:io' as io;
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:emetrix_flutter/app/core/native/clasificador_channel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vision/flutter_vision.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart' show rootBundle;

class ObjectDetect extends StatefulWidget {
  const ObjectDetect({
    Key? key,
  }) : super(key: key);

  @override
  State<ObjectDetect> createState() => _ObjectDetectState();
}

class _ObjectDetectState extends State<ObjectDetect> {
  late CameraController controller;
  late List<Map<String, dynamic>> yoloResults;
  CameraImage? cameraImage;
  bool isLoaded = false;
  bool isDetecting = false;
  late List<CameraDescription> cameras;

  var x = 0.0;
  var y = 0.0;
  var h = 0.0;
  var w = 0.0;
  var label = "";

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
    controller.initialize().then((value) {
      controller.lockCaptureOrientation();
      loadYoloModel().then((value) {
        setState(() {
          isLoaded = true;
          isDetecting = false;
          yoloResults = [];
        });
      });
    });
  }

  @override
  void dispose() async {
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
    return Stack(
      children: [
        Container(
          width: size.width,
          height: size.height * 0.845,
          child: CameraPreview(
            controller,
          ),
        ),
        ...displayBoxesAroundRecognizedObjects(size),
        Positioned(
          bottom: 0,
          width: MediaQuery.of(context).size.width,
          child: Container(
            width: size.width,
            height: size.height * 0.117,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    width: 5, color: Colors.white, style: BorderStyle.solid),
              ),
              child: isDetecting
                  ? IconButton(
                      onPressed: () async {
                        stopDetection();
                      },
                      icon: const Icon(
                        Icons.stop,
                        color: Colors.red,
                      ),
                      iconSize: 30,
                    )
                  : IconButton(
                      onPressed: () async {
                        await startDetection();
                      },
                      icon: const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                      ),
                      iconSize: 30,
                    ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> loadYoloModel() async {
    try {
      await vision.loadYoloModel(
          labels: 'assets/labels.txt',
          modelPath: 'assets/model.tflite',
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

  Future<void> yoloOnFrame(CameraImage cameraImage) async {
    final result = await vision.yoloOnFrame(
        bytesList: cameraImage.planes.map((plane) => plane.bytes).toList(),
        imageHeight: cameraImage.height,
        imageWidth: cameraImage.width,
        iouThreshold: 0.4,
        confThreshold: 0.4,
        classThreshold: 0.4);

    if (result.isNotEmpty) {
      print(result);

      setState(() {
        yoloResults = result;
      });
    }
  }

  Future<void> startDetection() async {
    setState(() {
      isDetecting = true;
    });
    if (controller.value.isStreamingImages) {
      return;
    }
    await controller.startImageStream((image) async {
      if (isDetecting) {
        cameraImage = image;
        yoloOnFrame(image);
      }
    });
  }

  Future<void> stopDetection() async {
    setState(() {
      isDetecting = false;
      yoloResults.clear();
    });
  }

  List<Widget> displayBoxesAroundRecognizedObjects(Size screen) {
    if (yoloResults.isEmpty) return [];

    double screenWidth = screen.width;
    double screenHeight = screen.height * 0.845;

    return yoloResults.map((result) {
      final box = result["box"];
      String label = result["tag"];
      String porcentaje = (box[4] * 100).toStringAsFixed(0);

      final int imageWidth = 720;
      final int imageHeight = 1280;

      double xRatio = screenWidth / imageWidth;
      double yRatio = screenHeight / imageHeight;

      double x1Image = box[0];
      double y1Image = box[1];
      double x2Image = box[2];
      double y2Image = box[3];

      double x1Scaled = x1Image * xRatio;
      double y1Scaled = y1Image * yRatio;
      double x2Scaled = x2Image * xRatio;
      double y2Scaled = y2Image * yRatio;

      return Positioned(
        left: (screenWidth) - (x1Scaled / 0.75),
        top: (screenHeight) - (y1Scaled / 0.67),
        width: x2Scaled,
        height: y2Scaled,
        child: GestureDetector(
          onTap: () async {
            isLoaded = true;
            stopDetection();
            final photo = await savePhotho();

            final photo_cropped = await cropImage(
                photo,
                (720) - (x1Image / 0.75),
                (1280) - (y1Image / 0.678),
                x2Image * 1.3,
                y2Image);

            String fileName = DateTime.now().millisecondsSinceEpoch.toString() +
                '_cropped.png';
            String filePath =
                (await getTemporaryDirectory()).path + '/' + fileName;
            await File(filePath).writeAsBytes(photo_cropped);
            if (filePath == "") {
              isLoaded = false;
              return;
            }
            vision.closeYoloModel();
            Navigator.push(
              // ignore: use_build_context_synchronously
              this.context,
              MaterialPageRoute(
                builder: (context) => ImageViewerScreen(imagePath: filePath),
              ),
            );
          },
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
                    "$label $porcentaje%",
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

  Future<Uint8List> savePhotho() async {
    final photo = await controller.takePicture();

    Uint8List photoBytes = await photo.readAsBytes();

    return photoBytes;
  }

  Future<Uint8List> cropImage(Uint8List imageData, double x1, double y1,
      double width, double height) async {
    // Decodificar la imagen
    final codec = await ui.instantiateImageCodec(imageData);
    final frame = await codec.getNextFrame();
    final image = frame.image;

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    // Dibujar el recorte
    final paint = Paint();
    final rect = Rect.fromLTWH(x1, y1, width, height);
    final src = Rect.fromLTWH(x1, y1, width, height);
    canvas.drawImageRect(image, src, rect, paint);

    final picture = recorder.endRecording();
    final img = await picture.toImage(width.toInt(), height.toInt());
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);

    return byteData!.buffer.asUint8List();
  }
}

class ImageViewerScreen extends StatefulWidget {
  final String imagePath;

  ImageViewerScreen({required this.imagePath});

  @override
  State<ImageViewerScreen> createState() => _ImageViewerScreenState();
}

class _ImageViewerScreenState extends State<ImageViewerScreen> {
  final TFLiteClassifier classifier = TFLiteClassifier();
  bool isLoaded = false;
  String resultMax = "";

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<String> _copy(String assetPath) async {
    final path = '${(await getApplicationSupportDirectory()).path}/$assetPath';
    await io.Directory(dirname(path)).create(recursive: true);
    final file = io.File(path);
    if (!await file.exists()) {
      final byteData = await rootBundle.load(assetPath);
      await file.writeAsBytes(byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    }
    return file.path;
  }

  Future<void> init() async {
    final imagePath = await getImageFilePath('assets/barefoot_pinotnoir.webp');
    final List<ClassificationResult> results =
        await classifier.classifyImage(imagePath);

    if (results.isNotEmpty) {
      String label = results[0].label;
      double score = results[0].score;
      results.forEach((result) {
        if (result.score > score) {
          label = result.label;
          score = result.score;
        }
      });
      setState(() {
        resultMax = "$label - ${score.toStringAsFixed(2)}";
      });
    } else {
      setState(() {
        resultMax = "Sin resultados";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clasificador'),
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.8,
            child: Center(
              /*child: Image.file(
                File('assets/barefoot_pinotnoir.webp'),
              ), */
              child: Image.asset('assets/gomichela.webp'),
            ),
          ),
          Center(
            child: Text("Clase: $resultMax"),
          )
        ],
      ),
    );
  }

  Future<String> getImageFilePath(String assetPath) async {
    final byteData = await rootBundle.load(assetPath);
    final file = File(
        '${(await getTemporaryDirectory()).path}/${assetPath.split('/').last}');
    await file.writeAsBytes(byteData.buffer.asUint8List());
    return file.path;
  }
}
