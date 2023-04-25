import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:geolocator/geolocator.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';
import 'package:emetrix_flutter/app/ui/utils/widgets/widgets.dart';

class Gps extends ConsumerStatefulWidget {
  const Gps({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GpsState();
}

class _GpsState extends ConsumerState<Gps> {
  // Position? position;

  @override
  Widget build(BuildContext context) {
    return Buton(
        background: c.onSecondary,
        title: 'Obtenet GPS',
        style: t.mediumLight,
        onTap: () async {
          // position = await Geolocator.getCurrentPosition(
          //     desiredAccuracy: LocationAccuracy.high);
          // setState(() {});

          // if (position != null) {
          //   showDialog(
          //     context: context,
          //     builder: (context) {
          //       return AlertDialog(
          //         content: Text(
          //             'Su posicion: ${position?.latitude.toString() ?? '0'}'),
          //       );
          //     },
          //   );
          // }
        });
  }
}
