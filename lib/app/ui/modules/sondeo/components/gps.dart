import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/ui/modules/sondeo/components/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

// import 'package:emetrix_flutter/app/core/services/services.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class Gps extends ConsumerStatefulWidget {
  const Gps({
    super.key,
    required this.pregunta,
    required this.answer,
    this.mandatory = false, 
    required this.preguntawid,
  });
  final String pregunta;
  final Function(String?) answer;
  final bool mandatory;
  final Preguntas preguntawid;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GpsState();
}

class _GpsState extends ConsumerState<Gps> with AutomaticKeepAliveClientMixin {
  Position? position;
  LocationPermission? geolocator;
  bool loading = false;
  var stringManager;
  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final size = MediaQuery.of(context).size;
    // final isDark = ref.watch(themeProvider) == ThemeMode.dark;
    stringManager = ref.watch(stringManagerProvider(int.parse(widget.preguntawid.id ?? '0')));
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      color: widget.mandatory ? c.errorLight : c.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
            child: Text(widget.pregunta, style: t.subtitle),
          ),
          SizedBox(height: size.height * 0.01),
          stringManager.currentString.toString().isNotEmpty ?
          SizedBox(
                  height: size.height * 0.05,
                  child: Center(
                      child: Text(
                          stringManager.currentString)),
                ):
          geolocator == LocationPermission.always && position != null ||
                  geolocator == LocationPermission.whileInUse &&
                      position != null
              ? SizedBox(
                  height: size.height * 0.05,
                  child: Center(
                      child: Text(
                          '${position?.latitude}, ${position?.longitude}')),
                )
              : loading == true
                  ? SizedBox(
                      height: size.height * 0.05,
                      child: Center(
                        child: SizedBox(
                            height: size.height * 0.03,
                            width: size.height * 0.03,
                            child: Center(
                                child: CircularProgressIndicator(
                                    strokeWidth: 2, color: c.primary500))),
                      ),
                    )
                  : SizedBox(
                      height: size.height * 0.05,
                      child: const Center(child: Text('GPS') )),
          SizedBox(height: size.height * 0.01),
          Center(
            child: Buton(
                outlined: true,
                background: c.primary400,
                title: 'Obtenet GPS',
                style: t.mediumBlue2,
                onTap: () => getCurrentLocation()),
          ),
          SizedBox(height: size.height * 0.02),
        ],
      ),
    );
  }

  Future<void> getCurrentLocation() async {
    if (position != null) {
      stringManager.updateString('${position?.latitude}, ${position?.longitude}');
      widget.answer('${position?.latitude}, ${position?.longitude}');
      return;
    }

    setState(() {
      loading = !loading;
    });

    try {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best,
          forceAndroidLocationManager: false);
      stringManager.updateString('${position?.latitude}, ${position?.longitude}');
      widget.answer('${position?.latitude}, ${position?.longitude}');

      setState(() {});
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  Future<void> checkPermission() async {
    geolocator = await Geolocator.checkPermission();
    setState(() {});
  }

  @override
  bool get wantKeepAlive => true;
}
