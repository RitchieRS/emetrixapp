import 'package:emetrix_flutter/app/ui/modules/sondeo/components/components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Signature extends ConsumerStatefulWidget {
  const Signature({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignatureState();
}

class _SignatureState extends ConsumerState<Signature> {
  List<Offset> _points = <Offset>[];
  final GlobalKey _globalKey = GlobalKey();
  Uint8List? imageBytes;

  Future<Uint8List?> _capturePng() async {
    try {
      RenderRepaintBoundary boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List? pngBytes = byteData?.buffer.asUint8List();
      return pngBytes;
    } catch (e) {
      print(e);
      return null;
    }
  }

  void _clear() {
    setState(() {
      _points = [];
      imageBytes = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.6,
      width: size.width,
      child: Column(
        // shrinkWrap: true,
        children: [
          RepaintBoundary(
            key: _globalKey,
            child: GestureDetector(
              onPanUpdate: (DragUpdateDetails details) {
                setState(() {
                  RenderBox renderBox = context.findRenderObject() as RenderBox;
                  Offset localPosition =
                      renderBox.globalToLocal(details.globalPosition);
                  _points = List.from(_points)..add(localPosition);
                });
              },
              onPanEnd: (DragEndDetails details) {
                // _points.add(null);
              },
              child: CustomPaint(
                painter: FirmaPainter(_points),
                size: Size(size.width, size.height * 0.6),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _clear,
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                child: const Text('Limpiar'),
              ),
              ElevatedButton(
                onPressed: () async {
                  imageBytes = await _capturePng();
                  setState(() {});
                  // Hacer algo con la imagen PNG
                },
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                child: const Text('Guardar firma'),
              ),
            ],
          ),
          imageBytes != null
              ? const Text('images/signature1.PNG')
              : const SizedBox()
        ],
      ),
    );
    // CustomPaint(
    //   painter: DebugSignaturePainterCP(
    //     control: control,
    //     cp: false,
    //     cpStart: false,
    //     cpEnd: false,
    //   ),
    // ),
  }
}
