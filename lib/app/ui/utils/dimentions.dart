import 'dart:ui';

class Dimentions {
  final Size size = PlatformDispatcher.instance.views.first.physicalSize;
  final double pixelRatio =
      PlatformDispatcher.instance.views.first.devicePixelRatio;

  double getWidth() => size.width / pixelRatio;

  double getHeight() => size.height / pixelRatio;
}
