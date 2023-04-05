import 'dart:ui' as ui;
import 'dart:ui';

class Dimentions {
  final Size size = ui.window.physicalSize;
  final double pixelRatio = ui.window.devicePixelRatio;

  // final double width = size.width / pixelRatio;
  // final height = size.height / pixelRatio;

  double getWidth() {
    return size.width / pixelRatio;
  }

  double getHeight() {
    return size.height / pixelRatio;
  }

  // print('Screen width: $width, height: $height');
}
