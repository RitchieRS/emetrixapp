import 'dart:ui' as ui;
import 'package:emetrix_flutter/app/core/services/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:emetrix_flutter/app/ui/modules/sondeo/components/components.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class Signature extends ConsumerStatefulWidget {
  const Signature({super.key, required this.pregunta});
  final String pregunta;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignatureState();
}

class _SignatureState extends ConsumerState<Signature>
    with AutomaticKeepAliveClientMixin {
  List<Offset> _points = <Offset>[];
  final GlobalKey _globalKey = GlobalKey();
  Uint8List? imageBytes;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.6,
      width: size.width,
      child: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
            child: Text(widget.pregunta, style: t.subtitle),
          ),
          SizedBox(height: size.height * 0.02),
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
                size: Size(size.width, size.height * 0.55),
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
                  MesagessService.showSuccess(
                      context: context,
                      message: 'Firma Guardada',
                      marginBottom:
                          EdgeInsets.only(bottom: size.height * 0.77));

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
              ? const Center(child: Text('images/signature1.PNG'))
              : const SizedBox()
        ],
      ),
    );
  }

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
      debugPrint(e.toString());
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
  bool get wantKeepAlive => true;
}
