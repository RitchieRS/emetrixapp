import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class Scanner extends ConsumerStatefulWidget {
  const Scanner({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ScannerState();
}

class _ScannerState extends ConsumerState<Scanner> {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;

    controller.scannedDataStream.listen((scanData) {
      // Aquí puedes manejar los datos del código QR leído
      debugPrint(scanData.toString());
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        SizedBox(
          height: size.height * 0.6,
          width: size.width,
          child: QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
          ),
        ),
        result != null
            ? Text(
                'Barcode Type: ${describeEnum(result!.format)}   Data: ${result?.code}')
            : const Text('Scan a code'),
      ],
    );
  }
}
