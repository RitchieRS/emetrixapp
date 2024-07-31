import 'package:camera/camera.dart';
import 'package:emetrix_flutter/app/core/native/clasificador_channel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vision/flutter_vision.dart';
import 'package:image/image.dart' as img;
import 'dart:async';
import 'dart:io';
import 'dart:io' as io;
import 'dart:typed_data';
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
  String resultMax = "";

  Map<String, String> _classificationResults = {};
  final TFLiteClassifier classifier = TFLiteClassifier();

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

  Uint8List _cropImage(
      CameraImage image, double x1, double y1, double x2, double y2) {
    final img.Image convertedImage = _convertYUV420toImage(image);

    final int left = (x1 * convertedImage.width).toInt();
    final int top = (y1 * convertedImage.height).toInt();
    final int right = (x2 * convertedImage.width).toInt();
    final int bottom = (y2 * convertedImage.height).toInt();

    final img.Image croppedImage = img.copyCrop(
      convertedImage,
      x: left,
      y: top,
      width: right - left,
      height: bottom - top,
    );

    return Uint8List.fromList(img.encodeJpg(croppedImage));
  }

  int getColor(int r, int g, int b) {
    return (255 << 24) | (r << 16) | (g << 8) | b;
  }

  img.Image _convertYUV420toImage(CameraImage image) {
    final int width = image.width;
    final int height = image.height;
    final int uvRowStride = image.planes[1].bytesPerRow;
    final int uvPixelStride = image.planes[1].bytesPerPixel!;

    final img.Image imgImage = img.Image(width: width, height: height);

    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        final int uvIndex = (x ~/ 2) * uvPixelStride + (y ~/ 2) * uvRowStride;
        final int index = y * width + x;

        final int yValue = image.planes[0].bytes[index];
        final int uValue = image.planes[1].bytes[uvIndex];
        final int vValue = image.planes[2].bytes[uvIndex];

        final int r = (yValue + 1.4075 * (vValue - 128)).round();
        final int g =
            (yValue - 0.3455 * (uValue - 128) - 0.7169 * (vValue - 128))
                .round();
        final int b = (yValue + 1.779 * (uValue - 128)).round();

        imgImage.setPixel(
            x,
            y,
            getColor(
              r.clamp(0, 255),
              g.clamp(0, 255),
              b.clamp(0, 255),
            ) as img.Color);
      }
    }
    return imgImage;
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

  Future<void> yoloOnFrame(CameraImage cameraImage) async {
    final result = await vision.yoloOnFrame(
        bytesList: cameraImage.planes.map((plane) => plane.bytes).toList(),
        imageHeight: cameraImage.height,
        imageWidth: cameraImage.width,
        iouThreshold: 0.3,
        confThreshold: 0.3,
        classThreshold: 0.3);

    if (result.isNotEmpty) {
      print(result);

      setState(() {
        yoloResults = result;
      });
    }

    for (var detectedObject in result) {
      final croppedImage = _cropImage(
        cameraImage,
        detectedObject['box'][0],
        detectedObject['box'][1],
        detectedObject['box'][2],
        detectedObject['box'][3],
      );

      String fileName =
          DateTime.now().millisecondsSinceEpoch.toString() + '_cropped.png';

      String filePath = (await getTemporaryDirectory()).path + '/' + fileName;
      await File(filePath).writeAsBytes(croppedImage);

      final List<ClassificationResult> results =
          await classifier.classifyImage(filePath);

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
        resultMax = "Sin resultados";
      }
      print("clasificador: $resultMax");

/*
      final classificationResults = await _flutterVision.yoloOnImage(
        bytesList: croppedImage,
        imageHeight: 640,
        imageWidth: 640,
      );

      */
      setState(() {
        _classificationResults[detectedObject['tag']] = resultMax;
      });
    }
  }

  static Future<File> _writeToFile(List<int> bytes) async {
    Directory tempDir = await getTemporaryDirectory();
    File tempFile = File('${tempDir.path}/las_moras_640.jpg');
    await tempFile.writeAsBytes(bytes);
    return tempFile;
  }

  Future<String> getImageFilePath(String assetPath) async {
    final byteData = await rootBundle.load(assetPath);
    final file = File(
        '${(await getTemporaryDirectory()).path}/${assetPath.split('/').last}');
    await file.writeAsBytes(byteData.buffer.asUint8List());
    return file.path;
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
      print(label);
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
                    "${resultMax}",
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

  Future<String> getClasification(
      double x1, double y1, double x2, double y2) async {
    final photo = await savePhotho();

    final photo_cropped = await cropImage(
        photo, (720) - (x1 / 0.75), (1280) - (y1 / 0.678), x2 * 1.3, y2);

    String fileName =
        DateTime.now().millisecondsSinceEpoch.toString() + '_cropped.png';

    String filePath = (await getTemporaryDirectory()).path + '/' + fileName;
    await File(filePath).writeAsBytes(photo_cropped);

    String resultMax = "";

    print("****");
    print(resultMax);

    return resultMax;
  }
}
