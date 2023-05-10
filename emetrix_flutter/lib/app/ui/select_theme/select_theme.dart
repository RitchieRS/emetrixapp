// ignore_for_file: use_build_context_synchronously

import 'package:emetrix_flutter/app/core/services/services.dart';
import 'package:emetrix_flutter/app/ui/modules/out_of_route/out_of_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';

import 'package:emetrix_flutter/app/ui/utils/utils.dart';
import 'package:emetrix_flutter/app/ui/utils/widgets/widgets.dart';

class SelectThemePage extends ConsumerStatefulWidget {
  const SelectThemePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SelectThemeState();
}

class _SelectThemeState extends ConsumerState<SelectThemePage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = ref.watch(themeProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: c.surface,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: c.surface,
              statusBarIconBrightness: isDark == ThemeMode.dark
                  ? Brightness.light
                  : Brightness.dark)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeIn(
              delay: const Duration(milliseconds: 500),
              child: Center(child: Text('Ponte cómodo.', style: t.subtitle))),
          FadeIn(
            delay: const Duration(milliseconds: 900),
            child: Center(
                child:
                    Text('Elige el tema de tu preferencia.', style: t.medium)),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          FadeIn(
            delay: const Duration(milliseconds: 1500),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          minimumSize:
                              Size(size.width * 0.8, size.height * 0.07),
                          alignment: Alignment.center,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          side: BorderSide(
                            color: isDark == ThemeMode.light
                                ? c.primary
                                : c.surface,
                          )),
                      onPressed: () {
                        ref.read(themeProvider.notifier).setLightTheme();
                      },
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.light_mode, color: c.primary),
                          ),
                          const Text('Modo claro'),
                        ],
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          minimumSize:
                              Size(size.width * 0.8, size.height * 0.07),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          side: BorderSide(
                            color: isDark == ThemeMode.dark
                                ? c.primary
                                : c.surface,
                          )),
                      onPressed: () {
                        ref.read(themeProvider.notifier).setDarkTheme();
                      },
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.dark_mode_outlined,
                                color: c.primary),
                          ),
                          const Text('Modo obscuro'),
                        ],
                      )),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Center(
                  child: isLoading
                      ? ButonLoading(
                          background: c.primary,
                          onFinish: null,
                          height: size.height * 0.065,
                          width: size.width * 0.85,
                        )
                      : Buton(
                          background: c.primary,
                          title: 'Siguiente',
                          style: t.mediumLight,
                          onTap: () async {
                            setState(() {
                              isLoading = !isLoading;
                            });
                            final navigator = Navigator.of(context);
                            await Future.delayed(const Duration(seconds: 2));

                            MesagessService.showMessage(
                                context: context,
                                duration: const Duration(seconds: 3),
                                message:
                                    'Selecciona las tiendas que visitarás.',
                                icon: Icons.store);

                            await navigator.pushReplacement(PageRouteBuilder(
                                pageBuilder: (_, animation, __) =>
                                    FadeTransition(
                                      opacity: animation,
                                      child: const OutOfRoutePage(),
                                    )));
                          }),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
