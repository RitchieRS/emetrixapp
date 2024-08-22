import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/ui/modules/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/ui/modules/sondeo/sondeo_individual.dart';
import 'package:emetrix_flutter/app/ui/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class ObjectDetectApi extends ConsumerStatefulWidget {
  const ObjectDetectApi({ 
                        Key? key,
                        required this.question,
                        this.mandatory = false,
                        required this.callback
                        });
  final Preguntas question;
  final bool mandatory;
  final Function(String?, String?) callback;


  @override
  _ObjectDetectApiState createState() => _ObjectDetectApiState();
}

class _ObjectDetectApiState extends ConsumerState<ObjectDetectApi> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _openCamera() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _sendImageToApi() async {
    if (_imageFile != null) {
      final uri = Uri.parse("http://54.202.132.137/scanImgResponse"); // Cambia esta URL a tu endpoint
      var request = http.MultipartRequest('POST', uri)
        ..files.add(await http.MultipartFile.fromPath('file', _imageFile!.path));
        request.headers.addAll({
                'Api-Token': 'HfHOm4at0DiuUs7ti8XifqQjZ7o66J38vsBLESMIIxoMyKPswj3rKtB0sDs7Kk1v',
              });

      var response = await request.send();

      var responseString = await response.stream.bytesToString();
      print('RespuestaApi: $responseString');
  
  
  // Decodificar el JSON y crear una instancia de ResponseModel
      var jsonResponse = jsonDecode(responseString);
      ImageResponse responseModel = ImageResponse.fromJson(jsonResponse);

      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ResultPage(response: 'Image uploaded successfully!',
                                                             responseModel: responseModel,
                                                             question: widget.question,
                                                              mandatory: widget.mandatory,
                                                              callback: widget.callback,
                                                             )),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ResultPage(response: 'Failed to upload image!',responseModel: responseModel)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = Platform.isIOS ? size.height * 0.12 : size.height * 0.1;

    return Scaffold(
      appBar: AppBar(
        title: Text('Captura el stand'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Centrar verticalmente los elementos
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_imageFile != null)
            Image.file(_imageFile!)
          else
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _openCamera,
            style: ElevatedButton.styleFrom(
              backgroundColor: c.primary600,// Color de fondo azul
              padding: EdgeInsets.only(bottom: Platform.isIOS ? size.height * 0.04 : 0), // Espaciado interno
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // Bordes ligeramente redondeados
              ),
            ),
            child: const Icon(
                Icons.camera_alt,
                color: Colors.white, // Color del icono blanco
                size: 24, // Tamaño del icono
              ),
          ),
          if (_imageFile != null)
            ElevatedButton(
              onPressed: _sendImageToApi,
             style: ElevatedButton.styleFrom(
              backgroundColor: c.primary600,// Color de fondo azul
              padding: EdgeInsets.only(bottom: Platform.isIOS ? size.height * 0.04 : 0), // Espaciado interno
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // Bordes ligeramente redondeados
              ),
            ),
            child: const Text('Analizar'
                              ,style: TextStyle(
                        color: Colors.white, // Texto blanco
                      )),
            )
        ],
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  final String response;
  final ImageResponse responseModel;
   
  final Preguntas question;
  final bool mandatory;
  final Function(List<String>?) selectedItems;
  final Function(String?, String?) callback;
  const ResultPage({
                   Key? key, 
                   required this.response, 
                   required this.responseModel,
                   required this.question,
                   this.mandatory = false,
                   required this.selectedItems,
                   required this.callback
                   }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = Platform.isIOS ? size.height * 0.12 : size.height * 0.1;
    return Scaffold(
      appBar: AppBar(
        title: Text('Imagen de ${responseModel.imgUrl}'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Centrar verticalmente los elementos
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children:[ CachedNetworkImage(
          imageUrl: 'http://${responseModel.imgUrl}', // Ruta completa a la imagen
          placeholder: (context, url) => CircularProgressIndicator(), // Preloader
          errorWidget: (
            context, url, error) => Icon(Icons.error), // Manejando errores
        ),
         ElevatedButton(
              onPressed: () async {
                                /*await Navigator.push(context, CupertinoPageRoute(builder: (context) {
                                      var sondeoItem= null;
                                      var  store = null;
                                      return // sondeosList2[index].preguntas?.first.tipo == 'asistencia'
                                              SingleSondeoPage(
                                                  store: store,
                                                  sondeoItem: sondeoItem,
                                                  index: 0,
                                                  stepsLenght: 0,
                                                  storeUuid: '',
                                                  stepUuid:  '',
                                                );
                                }));*/
                                },
             style: ElevatedButton.styleFrom(
              backgroundColor: c.primary600,// Color de fondo azul
              padding: EdgeInsets.only(bottom: Platform.isIOS ? size.height * 0.04 : 0), // Espaciado interno
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // Bordes ligeramente redondeados
              ),
            ),
            child: const Text('Aceptar',
                         style: TextStyle(
                          color: Colors.white, // Texto blanco
                        )),
            )
            ],
      ),
    );
  }
}

class CoordinateApi {
  final String category;
  final int cordBottom;
  final int cordLeft;
  final int cordRight;
  final int cordTop;
  final int imgNum;
  final String predictCode;

  CoordinateApi({
    required this.category,
    required this.cordBottom,
    required this.cordLeft,
    required this.cordRight,
    required this.cordTop,
    required this.imgNum,
    required this.predictCode,
  });

  // Factory constructor para crear una instancia de Coordinate desde JSON
  factory CoordinateApi.fromJson(Map<String, dynamic> json) {
    return CoordinateApi(
      category: json['category'],
      cordBottom: json['cord_bottom'],
      cordLeft: json['cord_left'],
      cordRight: json['cord_right'],
      cordTop: json['cord_top'],
      imgNum: json['img_num'],
      predictCode: json['predict_code'],
    );
  }

  // Método para convertir una instancia de Coordinate a JSON
  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'cord_bottom': cordBottom,
      'cord_left': cordLeft,
      'cord_right': cordRight,
      'cord_top': cordTop,
      'img_num': imgNum,
      'predict_code': predictCode,
    };
  }
}

class Total {
  final Map<String, int> snCounts;

  Total({required this.snCounts});

  // Factory constructor para crear una instancia de Total desde JSON
  factory Total.fromJson(Map<String, dynamic> json) {
    return Total(
      snCounts: Map<String, int>.from(json),
    );
  }

  // Método para convertir una instancia de Total a JSON
  Map<String, dynamic> toJson() {
    return Map<String, dynamic>.from(snCounts);
  }
}

class ImageResponse {
  final List<CoordinateApi> coordinates;
  final String imgUrl;
  final Total total;

  ImageResponse({
    required this.coordinates,
    required this.imgUrl,
    required this.total,
  });

  // Factory constructor para crear una instancia de ResponseModel desde JSON
  factory ImageResponse.fromJson(Map<String, dynamic> json) {
    return ImageResponse(
      coordinates: (json['coordinates'] as List)
          .map((coord) => CoordinateApi.fromJson(coord))
          .toList(),
      imgUrl: json['img_url'],
      total: Total.fromJson(json['total']),
    );
  }

  // Método para convertir una instancia de ResponseModel a JSON
  Map<String, dynamic> toJson() {
    return {
      'coordinates': coordinates.map((coord) => coord.toJson()).toList(),
      'img_url': imgUrl,
      'total': total.toJson(),
    };
  }
}