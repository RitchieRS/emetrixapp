import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:emetrix_flutter/app/core/services/services.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';
import 'package:emetrix_flutter/app/core/modules/stores/stores.dart';

class MapsPage extends ConsumerStatefulWidget {
  const MapsPage({super.key, this.store});
  final Store? store;

  @override
  ConsumerState<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends ConsumerState<MapsPage> {
  PermissionStatus permission = PermissionStatus.denied;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  String? _darkMapStyle;

  final CameraPosition _defaultMexico = const CameraPosition(
    target: LatLng(19.451054, -99.125519),
    zoom: 11,
  );

  @override
  void initState() {
    super.initState();
    _loadMapStyles();
    _setMapStyle(ref);
    requestLocationPermission();
  }

  @override
  void dispose() {
    disp0se();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double lat = widget.store?.latitud ?? _defaultMexico.target.latitude;
    final double long =
        widget.store?.longitud ?? _defaultMexico.target.longitude;

    final Marker currentMarker = Marker(
      markerId: const MarkerId('StoreMarker'),
      infoWindow: const InfoWindow(title: 'Tienda'),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(lat, long),
    );

    final CameraPosition current = CameraPosition(
      target: LatLng(lat, long),
      zoom: 17,
    );

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: size.height,
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
                  height: size.height * 0.23,
                  width: size.width,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AppAssets.location,
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
    final double lat = widget.store?.latitud ?? 0;
    final double long = widget.store?.longitud ?? 0;
    CameraPosition kLake = CameraPosition(
      target: LatLng(lat, long),
      zoom: 19,
    );

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(kLake));
  }

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
