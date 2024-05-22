import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:emetrix_flutter/app/core/global/core.dart';
import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/core/services/theme/theme.dart';
import 'package:emetrix_flutter/app/ui/modules/sondeo/components/controller.dart';
import 'package:emetrix_flutter/app/ui/utils/colors.dart';
import 'package:emetrix_flutter/app/ui/utils/text_styles.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:ui' as ui;
import 'package:image/image.dart' as img;

class Coordinate {
  final double x;
  final double y;
  final double xf;
  final double yf;
  final double porcentaje;
  final String idPregunta;

  Coordinate({
    required this.x,
    required this.y,
    required this.xf,
    required this.yf,
    required this.porcentaje,
    required this.idPregunta,
  });

  @override
  String toString() {
    return '[$x, $y, $xf, $yf]';
  }
}

final selectedAreasProvider =
    StateProvider.family<List<Coordinate>, int>((ref, key) => []);

class Areas extends ConsumerStatefulWidget {
  final Preguntas pregunta;
  final bool mandatory;
  final Preguntas preguntaSeleccionada;
  final Function(String?, String?) callback;
  final Function(File?) photo;
  final Function(List<Coordinate>?) selectedAreas;

  const Areas(
      {super.key,
      required this.pregunta,
      required this.preguntaSeleccionada,
      required this.callback,
      required this.photo,
      required this.selectedAreas,
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

  @override
  void dispose() {
    // Llamamos a widget.selectedAreas con null cuando el widget ya no está en el árbol de widgets.
    widget.selectedAreas(areasSeleccionadas);
    logger.i("Areas sin ver");
    super.dispose();
  }

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
        // Guarda la imagen recortada en la misma ruta que la original
        String originalPath = imageFile.path;
        String extension =
            originalPath.substring(originalPath.lastIndexOf('.'));
        String resizedPath = originalPath.replaceAll(extension, '_resized.jpg');
        File resizedFile = File(resizedPath);
        resizedFile.writeAsBytesSync(img.encodeJpg(croppedImage));

        ref
            .read(imageFileProviderFamily(
                int.parse(widget.pregunta.id.toString())))!
            .file = resizedFile;
        setWidthHeightImage();

        widget.photo(resizedFile);

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

  void _addSelectedArea(double x0, double y0, double xf, double yf) {
    if (x0 >= 0 &&
        y0 >= 0 &&
        xf <= _imageWidth &&
        yf <= _imageHeight.toDouble()) {
      double realX0 = x0 / _imageWidth;
      double realY0 = y0 / _imageHeight;
      double realXf = xf / _imageWidth;
      double realYf = yf / _imageHeight;

      double areaWidth = (realXf - realX0) * 100;
      double areaHeight = (realYf - realY0) * 100;
      double areaPercentage = areaWidth * areaHeight;

      final newArea = Coordinate(
        x: realX0,
        y: realY0,
        xf: realXf,
        yf: realYf,
        idPregunta: widget.preguntaSeleccionada.id!,
        porcentaje: areaPercentage,
      );

      ref
          .read(selectedAreasProvider(int.parse(
                  (widget.pregunta.id! + widget.preguntaSeleccionada.id!)))
              .notifier)
          .state
          .add(newArea);
      setState(() {
        //_selectedAreaPercentage = areaPercentage;

        final coordinates = ref.watch(selectedAreasProvider(int.parse(
            (widget.pregunta.id! + widget.preguntaSeleccionada.id!))));
        //widget.selectedAreas(coordinates);
        areasSeleccionadas = coordinates;
        _x = 0;
        _y = 0;
        _width = 0;
        _height = 0;
      });
    }
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

  void _drawSelectedArea(Coordinate coordinate) {
    setState(() {
      _x = coordinate.x * _imageWidth.toDouble();
      _y = coordinate.y * _imageHeight.toDouble();
      _width = (coordinate.xf - coordinate.x) * _imageWidth.toDouble();
      _height = (coordinate.yf - coordinate.y) * _imageHeight.toDouble();

      _width += _x;
      _height += _y;
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
                            _drawSelectedArea(coordinate);
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
                  Container(
                    width: size.width,
                    height: size.width,
                    child: Image.file(imageFile),
                  ),
                Container(
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
                    _addSelectedArea(_x, _y, _width, _height);
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
  final Function(File?) photo;
  final Function(List<Coordinate>?) selectedAreas;
  final Function(int) orderPreguntaDependiente;

  const AreaFullPage({
    super.key,
    required this.pregunta,
    required this.mandatory,
    required this.callback,
    required this.photo,
    required this.selectedAreas,
    required this.orderPreguntaDependiente,
    this.depen,
  });

  @override
  ConsumerState<AreaFullPage> createState() => _AreaFullPageState();
}

class _AreaFullPageState extends ConsumerState<AreaFullPage> {
  List<Coordinate>? listAreas;
  File? file;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = ref.watch(themeProvider) == ThemeMode.dark;
    final primaryColor = c.primary500;

    final Preguntas _questionSelected = ref.watch(preguntaSelectedProvider);

    void _select(Preguntas pregunta) {
      setState(() {
        ref.read(preguntaSelectedProvider.notifier).state = pregunta;
        //_questionSelected = pregunta;
        logger.d("ID pregunta seleccionada ${_questionSelected.id}");
        logger.d("ID pregunta seleccionada** ${_questionSelected.ordenI}");
        widget.orderPreguntaDependiente(int.parse(_questionSelected.ordenI!));
      });
      if (listAreas?.length != null) {
        widget.selectedAreas(listAreas);
      }
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
                photo: (photo) {
                  //file = photo;
                  widget.photo(photo);
                },
                callback: widget.callback,
                selectedAreas: (areas) {
                  widget.selectedAreas(areas);
                },
              )
            : Container());
  }
}
