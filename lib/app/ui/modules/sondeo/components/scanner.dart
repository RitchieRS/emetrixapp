import 'package:emetrix_flutter/app/core/services/services.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class Scanner extends ConsumerStatefulWidget {
  const Scanner({
    super.key,
    required this.pregunta,
    this.mandatory = false,
  });
  final String pregunta;
  final bool mandatory;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ScannerState();
}

class _ScannerState extends ConsumerState<Scanner>
    with AutomaticKeepAliveClientMixin {
  String text = '';

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final size = MediaQuery.of(context).size;
    final paddingHorizontal = size.width * 0.04;
    final paddingVertical = size.height * 0.012;

    return Material(
      color: widget.mandatory ? c.errorLight : c.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
            child: Text(widget.pregunta, style: t.subtitle),
          ),
          SizedBox(height: paddingVertical),
          Center(
            child: Text(text, style: t.text, textAlign: TextAlign.center),
          ),
          SizedBox(height: paddingVertical),
          Center(
            child: Buton(
              outlined: true,
              background: c.primary500,
              title: 'Scanner',
              style: t.mediumBlue2,
              onTap: () => _openScanner(),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openScanner() async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ScannerFullPage(),
        ));
    setState(() {
      text = result;
    });
    // widget.getSignature(result);
  }

  @override
  bool get wantKeepAlive => true;
}

//---

class ScannerFullPage extends ConsumerStatefulWidget {
  const ScannerFullPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ScannerFullPageState();
}

class _ScannerFullPageState extends ConsumerState<ScannerFullPage> {
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
    final isDark = ref.watch(themeProvider) == ThemeMode.dark;

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          foregroundColor: isDark ? c.background : c.black,
          backgroundColor: c.surface,
          elevation: 0,
          systemOverlayStyle:
              isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
        ),
        body: Column(
          children: [
            SizedBox(
              height: size.height * 0.65,
              width: size.width,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            if (result != null)
              Text(
                'Tipo: ${describeEnum(result!.format)}\nInfo: ${result?.code}',
                textAlign: TextAlign.center,
              )
            else
              const Text('Escanea un código'),
            SizedBox(
              width: size.width * 0.85,
              child: ElevatedButton(
                onPressed: () => _returnScan(),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  enableFeedback: true,
                  shadowColor: c.surface,
                ),
                child: const Text('Siguiente'),
              ),
            )
          ],
        ));
  }

  void _returnScan() {
    if (result?.code == null) {
      MesagessService.showError(context, 'Escanee el código');
      return;
    }
    Navigator.pop(context, result?.code);
  }
}
