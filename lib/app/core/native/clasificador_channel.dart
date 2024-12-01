import 'package:flutter/services.dart';

class TFLiteClassifier {
  static const platform = MethodChannel('tflite_classifier');

  Future<List<ClassificationResult>> classifyImage(String imagePath) async {
    try {
      final Map<dynamic, dynamic> result = await platform
          .invokeMethod('classifyImage', {'imagePath': imagePath});

      Map<String, dynamic> resultMap = {};
      if (result.isNotEmpty) {
        resultMap = result.cast<String, dynamic>();
      }
      List<ClassificationResult> resultList = [];

      resultMap.forEach((label, score) {
        resultList.add(ClassificationResult(label, score));
      });

      print("Objetos detectados ${resultList.length}");

      if (result.isNotEmpty) {
      } else {
        resultList.add(ClassificationResult("Sin resultados", -1));
      }

      return resultList;
    } on PlatformException catch (e) {
      print("Error: '${e.message}'.");
      return [ClassificationResult("Sin resultados", -1)];
    }
  }
}

class ClassificationResult {
  final String label;
  final double score;

  ClassificationResult(this.label, this.score);

  Map<String, dynamic> toMap() {
    return {
      'label': label,
      'score': score,
    };
  }
}
