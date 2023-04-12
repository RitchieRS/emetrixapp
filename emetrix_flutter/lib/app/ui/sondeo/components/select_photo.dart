import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

import 'package:flutter/services.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class SelectPicture extends ConsumerStatefulWidget {
  const SelectPicture({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SelectPictureState();
}

class _SelectPictureState extends ConsumerState<SelectPicture> {
  File? image;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();

        showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
            builder: (context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: size.width * 0.02,
                        bottom: size.height * 0.02,
                        top: size.height * 0.02),
                    child: ListTile(
                        onTap: () async {
                          final navigator = Navigator.of(context);
                          await pickImage(ImageSource.gallery);
                          navigator.pop();
                          setState(() {});
                        },
                        title: const Text('Galería.'),
                        leading: const Icon(Icons.photo)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: size.width * 0.02, bottom: size.height * 0.02),
                    child: ListTile(
                        onTap: () async {
                          final navigator = Navigator.of(context);
                          await pickImage(ImageSource.camera);
                          navigator.pop();
                        },
                        title: const Text('Cámara.'),
                        leading: const Icon(Icons.camera)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: size.width * 0.02, bottom: size.height * 0.02),
                    child: ListTile(
                        onTap: () async {
                          final navigator = Navigator.of(context);
                          setState(() {
                            image = null;
                          });
                          navigator.pop();
                        },
                        title: Text('Cancelar', style: t.textError),
                        leading: Icon(Icons.close, color: c.error)),
                  ),
                ],
              );
            });
      },
      child: Align(
        alignment: Alignment.centerLeft,
        child: image != null
            ? Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(90),
                  child: Container(
                    height: size.height * 0.2,
                    width: size.height * 0.2,
                    color: c.surface,
                    child: Image.file(
                      image!,
                      fit: BoxFit.cover,
                      frameBuilder:
                          (context, child, frame, wasSynchronouslyLoaded) {
                        return frame == null
                            ? const Center(child: CircularProgressIndicator())
                            : child;
                      },
                    ),
                  ),
                ),
              )
            : Center(
                child: CircleAvatar(
                  backgroundColor: c.disabled.withOpacity(0.1),
                  radius: size.height * 0.1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera,
                        color: c.disabled.withOpacity(0.8),
                        size: size.height * 0.06,
                      ),
                      Text(
                        'Selecciona imagen',
                        style: t.textDisabled,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Future pickImage(ImageSource source) async {
    try {
      final image2 = await ImagePicker().pickImage(source: source);
      if (image2 == null) return;

      final imageTemporal = File(image2.path);
      setState(() {
        image = imageTemporal;
      });
    } on PlatformException catch (e) {
      print('error:$e');
    }
  }
}
