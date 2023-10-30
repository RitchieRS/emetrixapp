import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/core/services/services.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';
import 'package:path_provider/path_provider.dart';

class SelectPicture extends ConsumerStatefulWidget {
  const SelectPicture({
    super.key,
    required this.pregunta,
    this.saveCopy = false,
    this.mandatory = false,
    required this.image,
  });
  final Preguntas pregunta;
  final bool saveCopy;
  final bool mandatory;
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

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      color: widget.mandatory ? c.errorLight : c.surface,
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
                child: Container(
                  height: side,
                  width: side,
                  color: backColor,
                  child: image != null
                      ? Image.file(
                          image ?? File(''),
                          fit: BoxFit.cover,
                          frameBuilder:
                              (context, child, frame, wasSynchronouslyLoaded) {
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
          widget.saveCopy
              ? CheckboxListTile(
                  value: widget.saveCopy,
                  onChanged: null,
                  // onChanged: (newvalue) {},
                  title: const Text('Guardar copia'),
                  activeColor: c.primary500,
                  checkboxShape: const CircleBorder(),
                  controlAffinity: ListTileControlAffinity.leading,
                )
              : const SizedBox(),
          SizedBox(height: size.height * 0.02),
        ],
      ),
    );
  }

  void selectCameraType() async {
    if (widget.pregunta.tipo == 'foto') {
      pickImage(ImageSource.camera);
      return;
    }
    if (widget.pregunta.tipo == 'fotoGuardarCopia') {
      pickImage(ImageSource.camera);
      await saveImageOnGallery();
      return;
    }
    if (widget.pregunta.tipo == 'imagen') {
      pickImage(ImageSource.gallery);
      return;
    }
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final image2 = await ImagePicker().pickImage(source: source);
      if (image2 == null) return;

      setState(() => image = File(image2.path));
      widget.image(image);
    } on PlatformException catch (e) {
      debugPrint('error:$e');
      widget.image(null);
    }
  }

  Future<void> saveImageOnGallery() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/image.jpg';
    await File(path).writeAsBytes(await image!.readAsBytes());
    await ImageGallerySaver.saveFile(image!.path);
  }

  @override
  bool get wantKeepAlive => true;
}
