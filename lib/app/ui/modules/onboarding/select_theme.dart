// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';

import 'package:emetrix_flutter/app/core/services/services.dart';
import 'package:emetrix_flutter/app/ui/modules/out_of_route/out_of_route.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class SelectThemePage extends ConsumerStatefulWidget {
  const SelectThemePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SelectThemeState();
}

class _SelectThemeState extends ConsumerState<SelectThemePage> {
  bool isLoading = false;
  final padding = const EdgeInsets.all(8.0);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = ref.watch(themeProvider) == ThemeMode.dark;
    final height = size.height * 0.052;
    final width = size.width * 0.9;
    final primaryColor = c.primary500;
    final appbar = AppBar(
        backgroundColor: c.surface,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: c.surface,
            statusBarIconBrightness:
                isDark ? Brightness.light : Brightness.dark));
    final minSize = Size(size.width * 0.7, size.height * 0.065);
    final miaxSize = Size(size.width * 0.9, size.height * 0.07);
    final radius =
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10));
    final lightStyle = OutlinedButton.styleFrom(
        minimumSize: minSize,
        maximumSize: miaxSize,
        alignment: Alignment.center,
        shape: radius,
        side: BorderSide(color: !isDark ? primaryColor : c.surface));
    final darkStyle = OutlinedButton.styleFrom(
        minimumSize: Size(size.width * 0.7, size.height * 0.065),
        maximumSize: Size(size.width * 0.9, size.height * 0.07),
        shape: radius,
        side: BorderSide(
          color: isDark ? primaryColor : c.surface,
        ));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appbar,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: size.height * 0.15),
          FadeIn(
              delay: const Duration(milliseconds: 500),
              child: Center(child: Text('Ponte cómodo.', style: t.subtitle))),
          FadeIn(
            delay: const Duration(milliseconds: 900),
            child: Center(
                child:
                    Text('Elige el tema de tu preferencia.', style: t.medium)),
          ),
          SizedBox(height: size.height * 0.03),
          FadeIn(
            delay: const Duration(milliseconds: 1500),
            child: Column(
              children: [
                Padding(
                  padding: padding,
                  child: OutlinedButton(
                      style: lightStyle,
                      onPressed: () =>
                          ref.read(themeProvider.notifier).setLightTheme(),
                      child: Row(
                        children: [
                          Padding(
                              padding: padding,
                              child:
                                  Icon(Icons.light_mode, color: primaryColor)),
                          const Text('Modo claro'),
                        ],
                      )),
                ),
                Padding(
                  padding: padding,
                  child: OutlinedButton(
                      style: darkStyle,
                      onPressed: () =>
                          ref.read(themeProvider.notifier).setDarkTheme(),
                      child: Row(
                        children: [
                          Padding(
                              padding: padding,
                              child: Icon(Icons.dark_mode_outlined,
                                  color: primaryColor)),
                          const Text('Modo obscuro'),
                        ],
                      )),
                ),
                SizedBox(height: size.height * 0.05),
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.2),
                  child: Center(
                    child: isLoading
                        ? ButonLoading(
                            background: primaryColor,
                            onFinish: null,
                            height: height,
                            width: width,
                          )
                        : ButonDimentions(
                            height: height,
                            width: width,
                            background: primaryColor,
                            title: 'Siguiente',
                            style: t.mediumLight,
                            onTap: () => goToStores()),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> goToStores() async {
    setState(() => isLoading = !isLoading);
    final navigator = Navigator.of(context);

    await navigator.pushReplacement(PageRouteBuilder(
        pageBuilder: (_, animation, __) => FadeTransition(
              opacity: animation,
              child: const OutOfRoutePage(),
            )));
  }
}
