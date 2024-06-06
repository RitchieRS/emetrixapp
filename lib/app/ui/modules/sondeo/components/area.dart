import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:emetrix_flutter/app/core/global/core.dart';
import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/core/services/theme/theme.dart';
import 'package:emetrix_flutter/app/ui/modules/sondeo/components/controller.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:ui' as ui;
import 'package:image/image.dart' as img;

class Coordinate {
  final double x0;
  final double y0;
  final double xf;
  final double yf;
  final double porcentaje;
  final String idPregunta;

  Coordinate({
    required this.x0,
    required this.y0,
    required this.xf,
    required this.yf,
    required this.porcentaje,
    required this.idPregunta,
  });

  factory Coordinate.fromJson(Map<String, dynamic> json) {
    return Coordinate(
      idPregunta: json['idPregunta'],
      porcentaje: json['porcentaje'],
      x0: json['x0'],
      y0: json['y0'],
      xf: json['xf'],
      yf: json['yf'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idPregunta': idPregunta,
      'porcentaje': porcentaje,
      'x0': x0,
      'y0': y0,
      'xf': xf,
      'yf': yf,
    };
  }

  @override
  String toString() {
    return '{"idPregunta": "$idPregunta","porcentaje": $porcentaje,"x0": $x0,"y0": $y0,"xf": $xf,"yf": $yf}';
  }
}

final selectedAreasProvider =
    StateProvider.family<List<Coordinate>, int>((ref, key) => []);

class Areas extends ConsumerStatefulWidget {
  final Preguntas pregunta;
  final bool mandatory;
  final Preguntas preguntaSeleccionada;
  final Function(String?, String?) callback;
  final Function(Coordinate) newArea;
  final Function(int?) removeArea;
  final bool multiple;

  const Areas(
      {super.key,
      required this.pregunta,
      required this.preguntaSeleccionada,
      required this.callback,
      required this.newArea,
      required this.removeArea,
      required this.multiple,
      required this.mandatory});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AreasState();
}

class _AreasState extends ConsumerState<Areas> {
  double _x = 0;
  double _y = 0;
  double _width = 0;
  double _height = 0;
  int _imageWidth = 0;
  int _imageHeight = 0;
  List<Coordinate> areasSeleccionadas = [];
  int? indexSelected;
  late AnimationController controller;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    final imageFile = pickedFile != null ? File(pickedFile.path) : null;

    if (imageFile != null) {
      final bytes = await imageFile.readAsBytes();
      img.Image? originalImage = img.decodeImage(bytes);

      if (originalImage != null) {
        int newHeight =
            (originalImage.height * 1024 / originalImage.width).round();

        img.Image resizedImage = img.copyResize(
          originalImage,
          width: 1024,
          height: newHeight,
        );

        // Recorta la imagen para que tenga dimensiones de 1024x1024 centradas
        int x = (resizedImage.width - 1024) ~/ 2;
        int y = (resizedImage.height - 1024) ~/ 2;
        //img.Image croppedImage = img.copyCrop(resizedImage, x, y, 1024, 1024);

        img.Image croppedImage =
            img.copyCrop(resizedImage, x: x, y: y, width: 1024, height: 1024);

// Guarda la imagen recortada con un nuevo nombre generado dinámicamente
        String originalPath = imageFile.path;
        String extension =
            originalPath.substring(originalPath.lastIndexOf('.'));

// Genera un nuevo nombre dinámico (por ejemplo, usando timestamp)
        String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
        String newFileName = "flutter_$timestamp.jpeg";
        String resizedPath =
            originalPath.replaceAll(originalPath.split('/').last, newFileName);

        File resizedFile = File(resizedPath);
        resizedFile.writeAsBytesSync(img.encodeJpg(croppedImage));

        ref
            .read(imageFileProviderFamily(
                int.parse(widget.pregunta.id.toString())))!
            .file = resizedFile;
        setWidthHeightImage();

        logger.i("**ID FOTO: ${widget.pregunta.id.toString()}");

        setState(() {});
      }
    }
  }

  void setWidthHeightImage() async {
    final imageFile = ref
        .read(imageFileProviderFamily(int.parse(widget.pregunta.id.toString())))
        ?.file;

    if (imageFile != null) {
      ui.Image image = await decodeImageFromList(imageFile.readAsBytesSync());

      _imageWidth = image.width;
      _imageHeight = image.height;
    }
  }

  void _addSelectedArea(double x0, double y0, double width, double height,
      double containerWidth, double containerHeight) {
    double xf = x0 + width;
    double yf = y0 + height;

    double realX0 = x0 * 1024 / containerWidth;
    double realY0 = y0 * 1024 / containerHeight;
    double realXf = xf * 1024 / containerWidth;
    double realYf = yf * 1024 / containerHeight;

    double areaWidth = realXf - realX0;
    double areaHeight = realYf - realY0;

    double areaPercentage = (areaWidth * areaHeight) / (1024 * 1024) * 100;

    areaPercentage = areaPercentage.clamp(0, 100);

    final newArea = Coordinate(
      x0: realX0,
      y0: realY0,
      xf: realXf,
      yf: realYf,
      idPregunta: widget.preguntaSeleccionada.id!,
      porcentaje: areaPercentage,
    );

    // Agregar la nueva área a la lista de áreas seleccionadas
    ref
        .read(selectedAreasProvider(
            int.parse(widget.pregunta.id! + widget.preguntaSeleccionada.id!)))
        .add(newArea);

    widget.newArea(newArea);
    setState(() {
      areasSeleccionadas = ref.watch(selectedAreasProvider(
          int.parse(widget.pregunta.id! + widget.preguntaSeleccionada.id!)));
      _x = 0;
      _y = 0;
      _width = 0;
      _height = 0;
    });
  }

  void _clearAreas() {
    ref
        .read(selectedAreasProvider(int.parse(
                (widget.pregunta.id! + widget.preguntaSeleccionada.id!)))
            .notifier)
        .state
        .clear();

    final coordinates = ref.watch(selectedAreasProvider(
        int.parse((widget.pregunta.id! + widget.preguntaSeleccionada.id!))));
    areasSeleccionadas = coordinates;

    widget.callback(widget.pregunta.id, widget.preguntaSeleccionada.id);

    setState(() {
      _x = 0;
      _y = 0;
      _width = 0;
      _height = 0;
    });
  }

  void _drawSelectedArea(
      Coordinate coordinate, double containerWidth, double containerHeight) {
    setState(() {
      // Calcula las coordenadas relativas al tamaño del contenedor
      _x = (coordinate.x0 / 1024) * containerWidth;
      _y = (coordinate.y0 / 1024) * containerHeight;
      _width = ((coordinate.xf - coordinate.x0) / 1024) * containerWidth;
      _height = ((coordinate.yf - coordinate.y0) / 1024) * containerHeight;

      // Ajusta el ancho y el alto para que estén dentro del rango del contenedor
      if (_x + _width > containerWidth) {
        _width = containerWidth - _x;
      }
      if (_y + _height > containerHeight) {
        _height = containerHeight - _y;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    setWidthHeightImage();
  }

  @override
  Widget build(BuildContext context) {
    final imageFile = ref
        .read(imageFileProviderFamily(int.parse(widget.pregunta.id.toString())))
        ?.file;
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
          child: Text("${widget.preguntaSeleccionada.pregunta}",
              style: t.subtitle),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: imageFile == null ? 0 : size.width * 0.15,
            width: size.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: ref
                  .watch(selectedAreasProvider(int.parse(
                      (widget.pregunta.id! + widget.preguntaSeleccionada.id!))))
                  .length,
              itemBuilder: (context, index) {
                final coordinate = ref
                    .watch(selectedAreasProvider(int.parse(
                            (widget.pregunta.id! +
                                widget.preguntaSeleccionada.id!)))
                        .notifier)
                    .state[index];

                return Dismissible(
                  direction: DismissDirection.vertical,
                  key: Key(coordinate.toString()),
                  onDismissed: (direction) {
                    ref
                        .watch(selectedAreasProvider(int.parse(
                                (widget.pregunta.id! +
                                    widget.preguntaSeleccionada.id!)))
                            .notifier)
                        .state
                        .removeAt(index);

                    widget.removeArea(index);

                    final coordinates = ref.watch(selectedAreasProvider(
                        int.parse((widget.pregunta.id! +
                            widget.preguntaSeleccionada.id!))));
                    areasSeleccionadas = coordinates;

                    widget.callback(
                        widget.pregunta.id, widget.preguntaSeleccionada.id);
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20.0),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  child: FadeInRight(
                    animate: true,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            indexSelected = index;
                            _drawSelectedArea(
                                coordinate, size.width, size.width);
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: indexSelected == index
                                    ? c.ok
                                    : c.primary300),
                            color: c.primary200.withOpacity(0.2),
                          ),
                          width: size.width * 0.15,
                          height: size.width * 0.15,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("${index + 1}", style: t.medium),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        GestureDetector(
          onTapDown: (details) {
            double imageX = details.localPosition.dx;
            double imageY = details.localPosition.dy;
            if (imageX >= 0 && imageY >= 0) {
              setState(() {
                _x = imageX;
                _y = imageY;
              });
            }
          },
          onPanUpdate: (details) {
            indexSelected = null;
            double imageX = details.localPosition.dx;
            double imageY = details.localPosition.dy;
            if (imageX >= 0 && imageY >= 0 && imageY < size.height * 0.62) {
              setState(() {
                _width = imageX - _x;
                _height = imageY - _y;
              });
            }
          },
          child: Container(
            child: Stack(
              children: [
                if (imageFile != null)
                  SizedBox(
                    width: size.width,
                    height: size.width,
                    child: Image.file(imageFile),
                  ),
                SizedBox(
                  width: size.width,
                  height: size.width,
                  child: CustomPaint(
                    painter: RectanglePainter(
                      rect: Rect.fromPoints(
                        Offset(_x, _y),
                        Offset(_x + _width, _y + _height),
                      ),
                      width: size.width,
                      height: size.width,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        imageFile != null
            ? Center(
                child: TextButton.icon(
                  onPressed: () {
                    int listLength = ref
                        .watch(selectedAreasProvider(int.parse(
                            (widget.pregunta.id! +
                                widget.preguntaSeleccionada.id!))))
                        .length;
                    if (listLength == 0 || widget.multiple) {
                      _addSelectedArea(
                        _x,
                        _y,
                        _width,
                        _height,
                        size.width,
                        size.width,
                      );
                    } else {
                      showMsj(
                          context: context,
                          title: "Ups!",
                          content: "Se alcanzó el limite de areas",
                          destructive: true,
                          buttonLabel: "OK",
                          onlyOk: true);
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Agregar Area'),
                ),
              )
            : Container(),
        Center(
          child: TextButton.icon(
            onPressed: () => _pickImage(ImageSource.camera),
            icon: const Icon(Icons.camera_alt_outlined),
            label: Text(imageFile == null ? 'Tomar Foto' : 'Actualizar Foto'),
          ),
        ),
      ],
    );
  }
}

class RectanglePainter extends CustomPainter {
  final Rect rect;
  final double width;
  final double height;
  RectanglePainter(
      {required this.width, required this.height, required this.rect});

  @override
  void paint(Canvas canvas, Size size) {
    double x0 = rect.left.clamp(0, width).toDouble();
    double y0 = rect.top.clamp(0, height).toDouble();
    double xf = rect.right.clamp(0, width).toDouble();
    double yf = rect.bottom.clamp(0, height).toDouble();

    final Paint paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawRect(Rect.fromLTRB(x0, y0, xf, yf), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

final preguntaSelectedProvider = StateProvider<Preguntas>((ref) => Preguntas());

class AreaFullPage extends ConsumerStatefulWidget {
  final Preguntas pregunta;
  final bool mandatory;
  final List<Preguntas>? depen;
  final Function(String?, String?) callback;
  final Function(List<Coordinate>?) selectedAreas;
  final bool multiple;

  const AreaFullPage({
    super.key,
    required this.pregunta,
    required this.mandatory,
    required this.callback,
    required this.selectedAreas,
    required this.multiple,
    this.depen,
  });

  @override
  ConsumerState<AreaFullPage> createState() => _AreaFullPageState();
}

class _AreaFullPageState extends ConsumerState<AreaFullPage> {
  int areasGuardadas = 0;
  List<Coordinate> listAreas = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = ref.watch(themeProvider) == ThemeMode.dark;
    final primaryColor = c.primary500;

    final Preguntas _questionSelected = ref.watch(preguntaSelectedProvider);

    void _select(Preguntas pregunta) {
      setState(() {
        ref.read(preguntaSelectedProvider.notifier).state = pregunta;
      });
    }

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          foregroundColor: isDark ? c.background : c.black,
          backgroundColor: c.surface,
          elevation: 0,
          title: Text('${widget.pregunta.pregunta}'),
          centerTitle: true,
          actions: <Widget>[
            PopupMenuButton<Preguntas>(
              onSelected: _select,
              itemBuilder: (BuildContext context) {
                return widget.depen!.map((Preguntas pregunta) {
                  return PopupMenuItem<Preguntas>(
                    value: pregunta,
                    child: Text('${pregunta.pregunta}'),
                  );
                }).toList();
              },
            ),
            CupertinoButton(
              onPressed: () {
                setState(() {
                  areasGuardadas = listAreas.length;
                  widget.selectedAreas(listAreas);
                  Navigator.pop(context);
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Icon(
                  Icons.save,
                  size: 22.0,
                  color: areasGuardadas == listAreas.length
                      ? Colors.black26
                      : Colors.lightGreen,
                ),
              ),
            )
          ],
          systemOverlayStyle:
              isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
        ),
        body: _questionSelected.pregunta != null
            ? Areas(
                key: UniqueKey(),
                pregunta: widget.pregunta,
                preguntaSeleccionada: _questionSelected,
                mandatory: widget.mandatory,
                callback: widget.callback,
                newArea: (area) => listAreas.add(area),
                removeArea: (index) => listAreas.removeAt(index!),
                multiple: widget.multiple,
              )
            : Container());
  }
}

/* Generar color aleatorio
Color generarColorAleatorio() {
  final Random random = Random();
  return Color.fromARGB(
    255,
    random.nextInt(256),
    random.nextInt(256),
    random.nextInt(256),
  );
}
*/