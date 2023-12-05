// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/ui/modules/sondeo/components/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hand_signature/signature.dart';
import 'package:emetrix_flutter/app/core/services/services.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

class Signature extends ConsumerStatefulWidget {
  const Signature({
    super.key,
    required this.pregunta,
    required this.getSignature,
    this.mandatory = false,
    required this.preguntawid,
  });
  final String pregunta;
  final Function(File?) getSignature;
  final bool mandatory;
  final Preguntas preguntawid;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignatureState();
}

class _SignatureState extends ConsumerState<Signature>
    with AutomaticKeepAliveClientMixin {
  late var signature;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    signature = ref.watch(
        imageFileProviderFamily(int.parse(widget.preguntawid.id ?? '0')));

    final size = MediaQuery.of(context).size;
    final isDark = ref.watch(themeProvider) == ThemeMode.dark;
    final backColor =
        isDark ? Theme.of(context).hintColor : Theme.of(context).highlightColor;

    return GestureDetector(
      onTap: () => getSignature(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        color: widget.mandatory ? c.errorLight : c.surface,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: Text(widget.pregunta, style: t.subtitle),
            ),
            SizedBox(height: size.height * 0.01),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  color: backColor,
                  height: size.height * 0.12,
                  width: size.width * 0.9,
                  child: signature.file != null
                      ? Image.file(signature.file!)
                      : const Center(
                          child: Text('Firmar'),
                        ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
          ],
        ),
      ),
    );
  }

  Future<void> getSignature() async {
    final result = await Navigator.push<File>(
        context,
        CupertinoPageRoute(
          builder: (context) => const SignatureFullPage(),
        ));
    imageCache.clear();
    setState(() {
      signature?.file = result;
    });
    widget.getSignature(result);
  }

  @override
  bool get wantKeepAlive => true;
}

//---

class SignatureFullPage extends ConsumerStatefulWidget {
  const SignatureFullPage({super.key});

  @override
  ConsumerState<SignatureFullPage> createState() => _SignatureFullPageState();
}

class _SignatureFullPageState extends ConsumerState<SignatureFullPage> {
  Color penColor = c.black;
  final List<Color> penColors = [
    c.black,
    c.primary500,
    Colors.blueGrey,
  ];
  final control = HandSignatureControl(
    threshold: 3.0,
    smoothRatio: 0.65,
    velocityRange: 2.0,
  );
  File? signatureImage;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = ref.watch(themeProvider) == ThemeMode.dark;
    final primaryColor = c.primary500;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        foregroundColor: isDark ? c.background : c.black,
        backgroundColor: c.surface,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                control.stepBack();
              },
              icon: Icon(Icons.undo, color: primaryColor)),
          IconButton(
              onPressed: _clear, icon: Icon(Icons.delete, color: primaryColor)),
        ],
        systemOverlayStyle:
            isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              height: size.height * 0.7,
              width: size.width * 0.9,
              decoration: BoxDecoration(
                  border: Border.all(color: primaryColor),
                  color: c.background,
                  borderRadius: BorderRadius.circular(10)),
              child: HandSignature(
                control: control,
                color: penColor,
                width: 1.0,
                maxWidth: 10.0,
                type: SignatureDrawType.shape,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () => _createImage(size, true),
                  icon: Icon(Icons.save_alt, color: primaryColor)),
              PopupMenuButton(
                icon: Icon(Icons.circle, color: penColor),
                itemBuilder: (context) => penColors
                    .map((color) => PopupMenuItem(
                        onTap: () => setState(() => penColor = color),
                        child: CircleAvatar(backgroundColor: color, radius: 6)))
                    .toList(),
              ),
            ],
          ),
          SizedBox(
            width: size.width * 0.85,
            child: ElevatedButton(
              onPressed: () => _createImage(size, false),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                enableFeedback: true,
                shadowColor: c.surface,
              ),
              child: const Text('Siguiente'),
            ),
          )
        ],
      ),
    );
  }

  Future _createImage(Size size, bool saveToGallery) async {
    try {
      if (!control.isFilled) {
        ref
            .read(messagesProvider.notifier)
            .showError(context, 'Dibuja tu firma');
        return;
      }
      final imageBytes = await control.toImage();
      final buffer = imageBytes?.buffer;
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      final filePath = '$tempPath/firma.png';

      final img = await File(filePath).writeAsBytes(buffer!.asUint8List(
          imageBytes?.offsetInBytes ?? 0, imageBytes?.lengthInBytes));
      signatureImage = img;
      setState(() {});

      //Save To Gallery
      if (saveToGallery) {
        await ImageGallerySaver.saveFile(signatureImage!.path);
        ref.read(messagesProvider.notifier).showSuccess(
            context: context, message: 'Firma descargada en galería');
        return;
      }
      //Enviar imagen al widget padre
      Navigator.pop(context, signatureImage);

      //
    } catch (error) {
      ref
          .read(messagesProvider.notifier)
          .showError(context, 'Error inseperado');
      //
    }
  }

  void _clear() {
    control.clear();
    signatureImage = null;
    setState(() {});
  }
}
