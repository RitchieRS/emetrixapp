import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/core/services/services.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class SelectPicture extends ConsumerStatefulWidget {
  const SelectPicture({
    super.key,
    required this.pregunta,
    this.saveCopy = false,
    required this.image,
  });
  final Preguntas pregunta;
  final bool saveCopy;
  final Function(File?) image;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SelectPictureState();
}

class _SelectPictureState extends ConsumerState<SelectPicture>
    with AutomaticKeepAliveClientMixin {
  File? image;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final size = MediaQuery.of(context).size;
    final isDark = ref.watch(themeProvider) == ThemeMode.dark;
    final backColor =
        isDark ? Theme.of(context).hintColor : Theme.of(context).highlightColor;
    final labelPadding = EdgeInsets.symmetric(horizontal: size.width * 0.04);
    final side = size.height * 0.25;

    return GestureDetector(
        onTap: () => handleImage(size: size),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: labelPadding,
              child:
                  Text(widget.pregunta.pregunta ?? 'NoData', style: t.subtitle),
            ),
            SizedBox(height: size.height * 0.01),
            GestureDetector(
              onTap: () => selectCameraType(),
              child: Center(
                child: ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.circular(10),
                  // borderRadius: BorderRadius.circular(90),
                  child: Container(
                    height: side,
                    width: side,
                    color: backColor,
                    child: image != null
                        ? Image.file(
                            image ?? File(''),
                            fit: BoxFit.cover,
                            frameBuilder: (context, child, frame,
                                wasSynchronouslyLoaded) {
                              return frame == null
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                          strokeWidth: 2))
                                  : child;
                            },
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.camera,
                                color: c.disabled.withOpacity(0.8),
                                size: size.height * 0.06,
                              ),
                              Text('Selecciona imagen', style: t.text),
                            ],
                          ),
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
          ],
        ));
  }

  void selectCameraType() {
    if (widget.pregunta.tipo == 'foto') {
      getImage(ImageSource.camera);
      return;
    }
    if (widget.pregunta.tipo == 'fotoGuardarCopia') {
      getImage(ImageSource.camera);
      //SaveOnGalery
      return;
    }
    if (widget.pregunta.tipo == 'imagen') {
      getImage(ImageSource.gallery);
      return;
    }
  }

  Future pickImage(ImageSource source) async {
    try {
      final image2 = await ImagePicker().pickImage(source: source);
      if (image2 == null) return;

      final imageTemporal = File(image2.path);
      setState(() => image = imageTemporal);
      widget.image(image);
    } on PlatformException catch (e) {
      debugPrint('error:$e');
      widget.image(null);
    }
  }

  void getImage(ImageSource source) async {
    await pickImage(source);
    setState(() {});
  }

  void getImageAndPop(ImageSource source) async {
    final navigator = Navigator.of(context);
    await pickImage(source);
    navigator.pop();
    setState(() {});
  }

  void handleImage({required Size size}) {
    FocusManager.instance.primaryFocus?.unfocus();
    final side = size.width * 0.02;
    final top = size.height * 0.02;

    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(left: side, bottom: top, top: top),
                child: ListTile(
                    onTap: () => getImageAndPop(ImageSource.gallery),
                    title: const Text('Galería.'),
                    subtitle: const Text('Seleccionar imagen de la galeria.'),
                    leading: const Icon(Icons.photo)),
              ),
              Padding(
                padding: EdgeInsets.only(left: side, bottom: top),
                child: ListTile(
                    onTap: () => getImageAndPop(ImageSource.camera),
                    title: const Text('Cámara.'),
                    subtitle: const Text('Tomar una foto con la cámara.'),
                    leading: const Icon(Icons.camera)),
              ),
              Padding(
                padding: EdgeInsets.only(left: side, bottom: top),
                child: ListTile(
                    onTap: () async {
                      final navigator = Navigator.of(context);
                      setState(() => image = null);
                      widget.image(null);
                      navigator.pop();
                    },
                    title: Text('Cancelar', style: t.textError),
                    leading: Icon(Icons.close, color: c.error)),
              ),
            ],
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}
