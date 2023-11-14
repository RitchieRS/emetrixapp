// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';
import 'package:emetrix_flutter/app/core/global/core.dart';
import 'package:emetrix_flutter/app/core/services/database/database.dart';
import 'package:emetrix_flutter/app/ui/modules/sondeo/controller.dart';
import 'package:emetrix_flutter/app/ui/modules/sondeo/widgets/bottom_buton.dart';
import 'package:emetrix_flutter/app/ui/modules/sondeo/widgets/custom_title.dart';
import 'package:flutter/services.dart' show PlatformException, rootBundle;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/core/services/services.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class MapView extends ConsumerStatefulWidget {
  const MapView({
    super.key,
    required this.store,
    required this.sondeoItem,
    required this.index,
    required this.storeUuid,
  });
  final Store2 store;
  final RespM sondeoItem;
  final int index;
  final String storeUuid;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MapViewState();
}

class _MapViewState extends ConsumerState<MapView> {
  PermissionStatus permission = PermissionStatus.granted;
  final _controller = Completer<GoogleMapController>();
  String? _darkMapStyle;
  Position? position;
  LocationPermission? geolocator;

  final CameraPosition _defaultMexico = const CameraPosition(
    target: LatLng(19.451054, -99.125519),
    zoom: 11,
  );

  @override
  void initState() {
    super.initState();
    // _checkPermission();
    _requestLocationPermission();
    // _getLocation();
    _loadMapStyles();
    _setMapStyle(ref);
  }

  @override
  void dispose() {
    disp0se();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final Marker currentMarker = Marker(
      markerId: const MarkerId('StoreMarker'),
      infoWindow: const InfoWindow(title: 'Tienda'),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(widget.store.latitud ?? _defaultMexico.target.latitude,
          widget.store.longitud ?? _defaultMexico.target.longitude),
    );

    final CameraPosition current = CameraPosition(
      target: LatLng(widget.store.latitud ?? _defaultMexico.target.latitude,
          widget.store.longitud ?? _defaultMexico.target.longitude),
      zoom: 17,
    );
    final finishedSections = ref.watch(finishedSondeos);

    return Scaffold(
        appBar: CustomTitle(title: widget.sondeoItem.sondeo),
        body: Column(
          children: [
            Container(
              height: size.height * 0.67,
              width: size.width,
              color: c.surface,
              child: permission.isGranted
                  ? GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: current,
                      markers: {
                        currentMarker,
                      },
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Concede los permisos necesarios.',
                            style: t.text2),
                        const CircularProgressIndicator(strokeWidth: 2)
                      ],
                    ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: FloatingActionButton(
            //     onPressed: () => _centerMap(),
            //     backgroundColor: c.onTertiary,
            //     child: const Icon(Icons.location_searching),
            //   ),
            // ),
            Container(
              height: size.height * 0.12,
              width: size.width,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width: size.width * 0.5,
                            color: c.surface,
                            child: Text(widget.store.tienda ?? 'México',
                                style: t.mediumBold)),
                        Text('Rango Gps: ${widget.store.rangoGPS.toString()}',
                            style: t.text),
                      ]),
                  SvgPicture.asset(AppAssets.location2,
                      height: size.height * 0.1),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomButon(
          onTap: () async {
            if (widget.store.checkGPS == '1') {
              await calculateChekInOut(finishedSections);
              return;
            } else {
              await setEntrance(finishedSections);
            }
          },
        ));
  }

  Future<void> calculateChekInOut(List<int> finishedSections) async {
//Crear Calculo de Check-In / CheckOut
    final storePosition =
        (widget.store.latitud ?? 0, widget.store.longitud ?? 0);

    if (position != null) {
      final distance = Geolocator.distanceBetween(position!.latitude,
          position!.longitude, storePosition.$1, storePosition.$2);
      final rango = double.parse(widget.store.rangoGPS.toString());

      if (distance <= rango) {
        //SI Pasa
        await setEntrance(finishedSections);
      } else {
        //No pasa
        await _showMessage('Fuera de rango',
            'No te encuentras a una distancia correcta, Acercate.');
      }
    }
  }

  Future setEntrance(List<int> finishedSections) async {
    final image = await pickImage(ImageSource.camera);
    showProgress(context: context, title: 'Calculando');
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        forceAndroidLocationManager: false);
    setState(() {});
    // await _getLocation();
    await Future.delayed(const Duration(seconds: 2));
    if (image != null && position != null) {
      await ref.read(databaseProvider).setCheckInOut(
            storeUuid: widget.storeUuid,
            lat: position?.latitude.toString() ?? '',
            long: position?.longitude.toString() ?? '',
            pic: image.toString(),
            isCheckin: widget.index == 0 ? true : false,
          );
      Navigator.pop(context);
      await finalize(finishedSections);
    } else {
      Navigator.pop(context);
      await _showMessage('Error', 'Ocurrio un error.');
    }
  }

  Future<void> _showMessage(String title, String content) async {
    await showMsj(
        context: context,
        title: title,
        content: content,
        destructive: false,
        onlyOk: true,
        canTapOutside: false,
        buttonLabel: 'Ok');
  }

  Future<void> _getLocation() async {
    try {
      if (geolocator == LocationPermission.always ||
          geolocator == LocationPermission.whileInUse) {
        position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: false);
        setState(() {});
      } else {
        geolocator = await Geolocator.requestPermission();
        setState(() {});
        if (geolocator == LocationPermission.always ||
            geolocator == LocationPermission.whileInUse) {
          position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.best,
              forceAndroidLocationManager: false);
          setState(() {});
        }
      }
    } catch (err) {
      logger.e(err.toString());
    }
  }

  // Future<void> _checkPermission() async {
  //   geolocator = await Geolocator.checkPermission();
  //   setState(() {});
  // }

  Future<void> finalize(List<int> finishedSections) async {
    //Save all progress and data to db
    if (!finishedSections.contains(widget.index) || finishedSections.isEmpty) {
      ref.read(finishedSondeos.notifier).state.add(widget.index);
    }
    ref
        .read(currentOptionProvider.notifier)
        .update((state) => state = widget.index + 1);
    ref.read(onlyFirstProvider.notifier).update((state) => false);

    await Future.delayed(const Duration(milliseconds: 800))
        .whenComplete(() => Navigator.pop(context));
  }

  Future<File?> pickImage(ImageSource source) async {
    try {
      final image2 = await ImagePicker().pickImage(source: source);
      if (image2 == null) return null;

      return File(image2.path);
    } on PlatformException catch (e) {
      debugPrint('Error extracting image:$e');
    }
    return null;
  }

  Future<void> _requestLocationPermission() async {
    permission = await Permission.locationWhenInUse.request();
    // permission = await Permission.locationWhenInUse.status;
    setState(() {});
  }

  // Future<void> _centerMap() async {
  //   final double lat = widget.store.latitud ?? 0;
  //   final double long = widget.store.longitud ?? 0;
  //   CameraPosition kLake = CameraPosition(
  //     target: LatLng(lat, long),
  //     zoom: 19,
  //   );

  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(kLake));
  // }

  Future<void> _loadMapStyles() async {
    _darkMapStyle = await rootBundle.loadString('assets/theme/maps_dark.json');
    // _lightMapStyle =
    //     await rootBundle.loadString('assets/map_styles/maps_light.json');
  }

  Future<void> _setMapStyle(WidgetRef ref) async {
    final controller = await _controller.future;
    final theme = ref.watch(themeProvider);
    if (theme == ThemeMode.dark) {
      controller.setMapStyle(_darkMapStyle);
    } else {
      controller.setMapStyle('[]');
    }
  }

  Future<void> disp0se() async {
    final controller = await _controller.future;
    controller.dispose();
  }

  //
}
