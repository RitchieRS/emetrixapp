import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vision/flutter_vision.dart';
import 'dart:io';
import 'dart:math';

class ObjectDetectApi extends StatefulWidget {
  const ObjectDetectApi({Key? key}) : super(key: key);

  @override
  State<ObjectDetectApi> createState() => _ObjectDetectState();
}

class _ObjectDetectState extends State<ObjectDetectApi> {
  late CameraController controller;
  late List<Map<String, dynamic>> yoloResults;
  bool isLoaded = false;
  late List<CameraDescription> cameras;
  File? _capturedImage;
  late FlutterVision vision;
  int? realImageWidth;
  int? realImageHeight;
  List<ui.Image> croppedImages = []; // Lista de imágenes recortadas
  bool isProcessing = false; // Variable para controlar el loader

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    vision = FlutterVision();
    cameras = await availableCameras();

    // Configura la cámara para capturar en vertical
    controller = CameraController(cameras[0], ResolutionPreset.high, imageFormatGroup: ImageFormatGroup.jpeg);

    await controller.initialize();
    controller.lockCaptureOrientation(DeviceOrientation.portraitUp); // Bloqueamos la orientación en vertical
    await loadYoloModel();
    setState(() {
      isLoaded = true;
      yoloResults = [];
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

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
          if (_capturedImage != null)
            Image.file(
              _capturedImage!,
              width: screenSize.width,
              height: screenSize.height * 0.845,
              fit: BoxFit.contain, // Mantiene la relación de aspecto en vertical
            )
          else
            Container(
              width: screenSize.width,
              height: screenSize.height * 0.845,
              child: CameraPreview(controller),
            ),
          ...displayBoxesAroundRecognizedObjects(screenSize),

          if (isProcessing)
            Center(
              child: CircularProgressIndicator(),
            ),

          Positioned(
            bottom: 0,
            width: screenSize.width,
            child: Container(
              width: screenSize.width,
              height: screenSize.height * 0.117,
              child: Center(
                child: Column(
                  children: [
                    if (_capturedImage == null)
                      ElevatedButton(
                        onPressed: captureImage,
                        child: Text("Capturar Foto"),
                      ),
                    if (_capturedImage != null && yoloResults.isEmpty)
                      ElevatedButton(
                        onPressed: analyzeImage,
                        child: Text("Analizar Imagen"),
                      ),
                    if (_capturedImage != null && yoloResults.isNotEmpty && croppedImages.isEmpty)
                      ElevatedButton(
                        onPressed: () => generateCroppedImagesFromDetection(),
                        child: Text("Recortar Imágenes"),
                      ),
                    if (croppedImages.isNotEmpty)
                      ElevatedButton(
                        onPressed: showCroppedImages,
                        child: Text("Mostrar Imágenes Recortadas"),
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

  Future<void> captureImage() async {
    try {
      final XFile photo = await controller.takePicture();
      setState(() {
        _capturedImage = File(photo.path);
        yoloResults.clear(); // Limpiamos los resultados anteriores si los hay
        croppedImages.clear(); // Limpiamos las imágenes recortadas anteriores
      });
    } catch (e) {
      print("Error al capturar la imagen: $e");
    }
  }

  Future<void> analyzeImage() async {
    try {
      if (_capturedImage == null) return;

      final Uint8List imageBytes = await _capturedImage!.readAsBytes();

      // Usamos la clase "Image" para obtener las dimensiones reales de la imagen capturada
      final decodedImage = await decodeImageFromList(imageBytes);
      realImageWidth = decodedImage.width;
      realImageHeight = decodedImage.height;

      final result = await vision.yoloOnImage(
        bytesList: imageBytes,
        imageHeight: realImageHeight!,  // Usamos la altura real de la imagen
        imageWidth: realImageWidth!,    // Usamos el ancho real de la imagen
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

 Future<void> generateCroppedImagesFromDetection() async {
  if (_capturedImage == null || yoloResults.isEmpty) return;

  setState(() {
    isProcessing = true; // Activar loader
  });

  final Uint8List imageBytes = await _capturedImage!.readAsBytes();
  final decodedImage = await decodeImageFromList(imageBytes);

  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height * 0.845;

  // Calcular el escalado utilizado para ajustar la imagen en la pantalla
  double imageAspectRatio = realImageWidth! / realImageHeight!;
  double screenAspectRatio = screenWidth / screenHeight;

  double displayWidth = screenWidth;
  double displayHeight = screenHeight;

  if (imageAspectRatio > screenAspectRatio) {
    displayHeight = displayWidth / imageAspectRatio;
  } else {
    displayWidth = displayHeight * imageAspectRatio;
  }

  double xRatio = displayWidth / realImageWidth!;
  double yRatio = displayHeight / realImageHeight!;

  double xOffset = (screenWidth - displayWidth) / 2;
  double yOffset = (screenHeight - displayHeight) / 2;

  croppedImages.clear();

  for (var result in yoloResults) {
    final box = result["box"];

    // Coordenadas originales de la caja (invertir X por Y para la rotación)
    double x1 = box[0];
    double y1 = box[1];
    double x2 = box[2];
    double y2 = box[3];

    // Invertir X e Y para la rotación
    double newX1 = y1;
    double newY1 = x1;
    double newX2 = y2;
    double newY2 = x2;

    // Asegurarse de que las coordenadas estén en orden correcto
    double left = min(newX1, newX2);
    double top = min(newY1, newY2);
    double right = max(newX1, newX2);
    double bottom = max(newY1, newY2);

    // Escalar las coordenadas a las dimensiones originales de la imagen
    double leftScaled = left * xRatio + xOffset;
    double topScaled = top * yRatio + yOffset;
    double widthScaled = (right - left) * xRatio;
    double heightScaled = (bottom - top) * yRatio;

    // Convertir las coordenadas escaladas de vuelta a las dimensiones originales de la imagen
    double originalX1 = (leftScaled - xOffset) / xRatio;
    double originalY1 = (topScaled - yOffset) / yRatio;
    double originalX2 = ((leftScaled + widthScaled) - xOffset) / xRatio;
    double originalY2 = ((topScaled + heightScaled) - yOffset) / yRatio;

    // Asegurarse de que las coordenadas estén en el orden correcto
    double cropX1 = min(originalX1, originalX2);
    double cropY1 = min(originalY1, originalY2);
    double cropX2 = max(originalX1, originalX2);
    double cropY2 = max(originalY1, originalY2);

    // Validación de las coordenadas para asegurarnos de que están dentro de los límites de la imagen original
    if (cropX1 < 0 || cropY1 < 0 || cropX2 > realImageWidth! || cropY2 > realImageHeight!) {
      continue; // Ignorar coordenadas inválidas
    }

    try {
      // Recortar la imagen en función del área del cuadro azul (coordenadas escaladas)
      ui.Image cropped = await cropImage(decodedImage, cropX1, cropY1, cropX2, cropY2);
      croppedImages.add(cropped);
    } catch (e) {
      print("Error al recortar imagen: $e");
    }
  }

  setState(() {
    isProcessing = false; // Desactivar loader una vez que termine
  });
}

Future<ui.Image> cropImage(ui.Image originalImage, double x1, double y1, double x2, double y2) async {
  // Asegurarse de que las coordenadas sean válidas
  double width = (x2 - x1).abs();
  double height = (y2 - y1).abs();

  if (width == 0 || height == 0) {
    throw Exception("Invalid image dimensions: width=$width, height=$height");
  }

  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);

  // Recortar el área seleccionada de la imagen original
  Rect srcRect = Rect.fromLTRB(x1, y1, x2, y2);
  Rect dstRect = Rect.fromLTWH(0, 0, width, height);

  canvas.drawImageRect(originalImage, srcRect, dstRect, Paint());
  final picture = recorder.endRecording();

  return await picture.toImage(width.toInt(), height.toInt());
}


  void showCroppedImages() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageCarousel(images: croppedImages),
      ),
    );
  }

  List<Widget> displayBoxesAroundRecognizedObjects(Size screenSize) {
    if (yoloResults.isEmpty || _capturedImage == null || realImageWidth == null || realImageHeight == null) return [];

    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height * 0.845;

    // Calcular la relación de aspecto de la imagen capturada
    double imageAspectRatio = realImageWidth! / realImageHeight!;
    double screenAspectRatio = screenWidth / screenHeight;

    double displayWidth = screenWidth;
    double displayHeight = screenHeight;

    // Ajustar el tamaño de la imagen en pantalla para que mantenga la relación de aspecto en horizontal
    if (imageAspectRatio > screenAspectRatio) {
      displayHeight = displayWidth / imageAspectRatio;
    } else {
      displayWidth = displayHeight * imageAspectRatio;
    }

    double xOffset = (screenWidth - displayWidth) / 2;
    double yOffset = (screenHeight - displayHeight) / 2;

    // Proporciones reales según la imagen capturada y el tamaño de la pantalla
    double xRatio = displayWidth / realImageWidth!;
    double yRatio = displayHeight / realImageHeight!;

    return yoloResults.map((result) {
      final box = result["box"];

      // Coordenadas originales de la caja
      double x1 = box[0];
      double y1 = box[1];
      double x2 = box[2];
      double y2 = box[3];

      // Invertir X e Y para la rotación
      double newX1 = y1;
      double newY1 = x1;
      double newX2 = y2;
      double newY2 = x2;

      // Asegurarse de que las coordenadas estén en orden correcto
      double left = min(newX1, newX2);
      double top = min(newY1, newY2);
      double right = max(newX1, newX2);
      double bottom = max(newY1, newY2);

      // Ajuste basado en la relación de aspecto
      double leftScaled = left * xRatio + xOffset;
      double topScaled = top * yRatio + yOffset;
      double widthScaled = (right - left) * xRatio;
      double heightScaled = (bottom - top) * yRatio;

      return Positioned(
        left: leftScaled,
        top: topScaled,
        width: widthScaled,
        height: heightScaled,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                border: Border.all(color: Colors.blue, width: 3.2),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
                color: Colors.blue,
              ),
              child: Text(
                "${result["tag"]} - ${(box[4] * 100).toStringAsFixed(0)}%",
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 13.0,
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}

class ImageCarousel extends StatelessWidget {
  final List<ui.Image> images;

  ImageCarousel({required this.images});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Imágenes Recortadas')),
      body: PageView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          final ui.Image image = images[index];
          return CustomPaint(
            painter: ImagePainter(image),
            child: Container(),
          );
        },
      ),
    );
  }
}

class ImagePainter extends CustomPainter {
  final ui.Image image;

  ImagePainter(this.image);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawImage(image, Offset(0, 0), Paint());
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
