import 'dart:async';

import 'package:emetrix_flutter/app/core/modules/stores/stores.dart';
import 'package:emetrix_flutter/app/core/services/services.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class MapView extends StatefulWidget {
  const MapView({
    super.key,
    required this.store,
  });
  final Store store;

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  PermissionStatus permission = PermissionStatus.denied;
  final _controller = Completer<GoogleMapController>();

  final CameraPosition _defaultMexico = const CameraPosition(
    target: LatLng(19.451054, -99.125519),
    zoom: 11,
  );

  @override
  void initState() {
    super.initState();
    requestLocationPermission();
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

    return Stack(
      children: [
        Container(
          height: size.height * 0.7,
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
                    Text('Concede los permisos necesarios.', style: t.text2),
                    const CircularProgressIndicator(strokeWidth: 2)
                  ],
                ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                onPressed: () => centerMap(),
                backgroundColor: Theme.of(context).primaryColor,
                child: const Icon(Icons.location_searching),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Container(
                height: size.height * 0.18,
                width: size.width,
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset(AppAssets.store,
                        height: size.height * 0.12),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: size.width * 0.55,
                            color: c.surface,
                            child: Text(widget.store.tienda ?? 'México',
                                style: t.mediumBold),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Text('Cadena: ${widget.store.idCadena ?? '0123456'}',
                              style: t.text),
                          Text('Grupo: ${widget.store.idGrupo ?? '987654'}',
                              style: t.text),
                          Text(
                              'Clasificación: ${widget.store.clasificacion ?? 'Clasified'}',
                              style: t.text),
                          Text('Rango Gps: ${widget.store.rangoGPS.toString()}',
                              style: t.text),
                        ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> requestLocationPermission() async {
    await Permission.locationWhenInUse.request();
    permission = await Permission.locationWhenInUse.status;
    setState(() {});
  }

  Future<void> centerMap() async {
    final double lat = widget.store.latitud ?? 0;
    final double long = widget.store.longitud ?? 0;
    CameraPosition kLake = CameraPosition(
      target: LatLng(lat, long),
      zoom: 19,
    );

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(kLake));
  }

  //
}
