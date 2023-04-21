import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';
import 'package:emetrix_flutter/app/core/stores/stores.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key, this.store});
  final Store? store;

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  PermissionStatus permission = PermissionStatus.denied;
  MapController mapController = MapController();
  static final mexico = LatLng(19.451054, -99.125519);
  final token =
      'pk.eyJ1IjoicGl0bWFjIiwiYSI6ImNsY3BpeWxuczJhOTEzbnBlaW5vcnNwNzMifQ.ncTzM4bW-jpq-hUFutnR1g';

  final markers = <Marker>[
    Marker(
      width: 80,
      height: 80,
      point: mexico,
      builder: (context) => Container(
        key: const Key('blue'),
        child: Icon(Icons.location_on, color: c.error),
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    requestLocationPermission();
  }

  @override
  void dispose() {
    super.dispose();
    mapController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            color: c.surface,
            child: permission.isGranted
                ? FlutterMap(
                    mapController: mapController,
                    options: MapOptions(
                      center: LatLng(widget.store?.latitud ?? mexico.latitude,
                          widget.store?.longitud ?? mexico.longitude),
                      zoom: 10,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
                        additionalOptions: {
                          'accessToken': token,
                          'id': 'mapbox/streets-v12'
                        },
                      ),
                      MarkerLayer(markers: markers),
                    ],
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
                  onPressed: centerMap,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: const Icon(Icons.location_searching),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  height: size.height * 0.23,
                  width: size.width,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/location.svg',
                        height: size.height * 0.135,
                        width: size.width * 0.1,
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: size.width * 0.55,
                              color: c.surface,
                              child: Text(widget.store?.tienda ?? 'México',
                                  style: t.mediumBold),
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Text(
                                'Cadena: ${widget.store?.idCadena ?? '0123456'}',
                                style: t.text),
                            Text('Grupo: ${widget.store?.idGrupo ?? '987654'}',
                                style: t.text),
                            Text(
                                'Clasificación: ${widget.store?.clasificacion ?? 'Clasified'}',
                                style: t.text),
                            Text(
                                'Rango Gps: ${widget.store?.rangoGPS.toString() ?? 'Gps Range'}',
                                style: t.text),
                          ]),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: Theme.of(context).primaryColor,
                  )),
            ),
          )
        ],
      ),
    );
  }

  Future<void> requestLocationPermission() async {
    await Permission.locationWhenInUse.request();
    permission = await Permission.locationWhenInUse.status;
    setState(() {});
  }

  Future<void> centerMap() async {
    mapController.moveAndRotate(
      LatLng(widget.store?.latitud ?? mexico.latitude,
          widget.store?.longitud ?? mexico.longitude),
      9,
      0,
    );
  }
}
