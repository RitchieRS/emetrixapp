import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

// import 'package:emetrix_flutter/app/ui/modules/sondeo/components/controller.dart';
import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/core/services/services.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class ImagesCarrusel extends ConsumerStatefulWidget {
  const ImagesCarrusel({
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

class _SelectPictureState extends ConsumerState<ImagesCarrusel>
    with AutomaticKeepAliveClientMixin {
  final images = <File>[];

  // var image;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // image = ref
    //     .watch(imageFileProviderFamily(int.parse(widget.pregunta.id ?? '0')));
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
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 600),
            child: images.isEmpty
                ? Center(
                    child: TextButton.icon(
                        onPressed: () => selectCameraType(),
                        icon: const Icon(Icons.add),
                        label: const Text('Añadir\nimagen')),
                  )
                : SizedBox(
                    height: side,
                    width: size.width,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        Center(
                          child: TextButton.icon(
                              onPressed: () => selectCameraType(),
                              icon: const Icon(Icons.add),
                              label: const Text('Añadir\nimagen')),
                        ),
                        ListView.builder(
                            itemCount: images.length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final item = images[index];

                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      clipBehavior: Clip.hardEdge,
                                      borderRadius: BorderRadius.circular(8),
                                      child: Container(
                                          height: side,
                                          width: side,
                                          color: backColor,
                                          child: Image.file(
                                            item,
                                            fit: BoxFit.cover,
                                            frameBuilder: (context, child,
                                                frame, wasSynchronouslyLoaded) {
                                              return frame == null
                                                  ? const Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                              strokeWidth: 2))
                                                  : child;
                                            },
                                          )),
                                    ),
                                    Container(
                                      height: 28,
                                      width: 28,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey,
                                      ),
                                      child: FittedBox(
                                        fit: BoxFit.cover,
                                        child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                images.removeAt(index);
                                              });
                                            },
                                            icon: const Icon(Icons.close,
                                                color: Colors.white)),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
          ),
          if (widget.saveCopy)
            CheckboxListTile(
              value: widget.saveCopy,
              onChanged: null,
              // onChanged: (newvalue) {},
              title: const Text('Guardar copia'),
              activeColor: c.primary500,
              checkboxShape: const CircleBorder(),
              controlAffinity: ListTileControlAffinity.leading,
            ),
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
      //await saveImageOnGallery();
      return;
    }
    if (widget.pregunta.tipo == 'imagen') {
      pickImage(ImageSource.gallery);
      return;
    }
    if (widget.pregunta.tipo == 'carrusel') {
      pickImage(ImageSource.gallery);
      return;
    }
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final image2 = await ImagePicker().pickImage(source: source);
      if (image2 == null) return;
      final tempImage = File(image2.path);
      final directory =
          await getApplicationDocumentsDirectory(); // AppData folder path
      final savedImagePath = '${directory.path}/${DateTime.now()}.jpg';
      File savedImage = await tempImage.copy(savedImagePath);

      // setState(() => image.file = File(savedImage.path));
      setState(() => images.add(File(savedImage.path)));
      // widget.image(image.file);
    } on PlatformException catch (e) {
      debugPrint('error:$e');
      widget.image(null);
    }
  }

  Future<void> saveImageOnGallery(int index) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/image.jpg';
    await File(path).writeAsBytes(await images[index].readAsBytes());
    await ImageGallerySaver.saveFile(images[index].path);
  }

  @override
  bool get wantKeepAlive => true;
}
