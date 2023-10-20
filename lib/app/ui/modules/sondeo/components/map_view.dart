import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:emetrix_flutter/app/core/modules/stores/stores.dart';
import 'package:emetrix_flutter/app/core/services/services.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class MapView extends ConsumerStatefulWidget {
  const MapView({
    super.key,
    required this.store,
  });
  final Store store;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MapViewState();
}

class _MapViewState extends ConsumerState<MapView> {
  PermissionStatus permission = PermissionStatus.denied;
  final _controller = Completer<GoogleMapController>();
  String? _darkMapStyle;

  final CameraPosition _defaultMexico = const CameraPosition(
    target: LatLng(19.451054, -99.125519),
    zoom: 11,
  );

  @override
  void initState() {
    super.initState();
    _loadMapStyles();
    _requestLocationPermission();
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

    return Column(
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
                    Text('Concede los permisos necesarios.', style: t.text2),
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
          // color: c.error,
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
              SvgPicture.asset(AppAssets.location2, height: size.height * 0.1),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _requestLocationPermission() async {
    await Permission.locationWhenInUse.request();
    permission = await Permission.locationWhenInUse.status;
    setState(() {});
  }

  Future<void> _centerMap() async {
    final double lat = widget.store.latitud ?? 0;
    final double long = widget.store.longitud ?? 0;
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
