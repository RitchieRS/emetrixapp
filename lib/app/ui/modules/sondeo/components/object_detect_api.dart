import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';


class ObjectDetectApi  extends ConsumerStatefulWidget {
  @override
  _ObjectDetectApi createState() => _ObjectDetectApi();
}

class _ObjectDetectApi extends ConsumerState<ObjectDetectApi> {
  File? _foto;

  Future<void> _abrirCamara() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (photo != null) {
        _foto = File(photo.path);
      } else {
        _foto = null;
      }
    });
  }

  Future<void> _enviarFoto() async {
    // Aquí debes implementar la lógica para enviar la foto a la API REST
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _foto != null
            ? Image.file(_foto!)
            : Text('No se ha tomado ninguna foto'),
        ElevatedButton(
          onPressed: _abrirCamara,
          child: Text('Abrir cámara'),
        ),
        ElevatedButton(
          onPressed: _enviarFoto,
          child: Text('Enviar foto'),
        ),
      ],
    );
  }
}