import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';

import 'package:emetrix_flutter/app/core/services/theme/theme.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';
import 'package:emetrix_flutter/app/ui/main/main_screen.dart';
import 'package:emetrix_flutter/app/ui/utils/widgets/widgets.dart';

class SelectTheme extends ConsumerStatefulWidget {
  const SelectTheme({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SelectThemeState();
}

class _SelectThemeState extends ConsumerState<SelectTheme> {
  bool isDark = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeIn(
              delay: const Duration(seconds: 1),
              child: Center(child: Text('Ponte comodo.', style: t.subtitle))),
          FadeIn(
            delay: const Duration(seconds: 2),
            child: Center(
                child:
                    Text('Elige el tema de tu preferencia.', style: t.medium)),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    minimumSize: Size(size.width * 0.8, size.height * 0.07),
                    alignment: Alignment.center,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    side: BorderSide(
                      color: isDark == false ? c.primary : c.surface,
                    )),
                onPressed: () {
                  ref
                      .read(isDarkModeProvider.notifier)
                      .update((state) => false);
                  setState(() {
                    isDark = false;
                  });
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
                    minimumSize: Size(size.width * 0.8, size.height * 0.07),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    side: BorderSide(
                      color: isDark == true ? c.primary : c.surface,
                    )),
                onPressed: () {
                  ref.read(isDarkModeProvider.notifier).update((state) => true);
                  setState(() {
                    isDark = true;
                  });
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.dark_mode_outlined, color: c.primary),
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
                    onFinish: () {},
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

                      await navigator.pushReplacement(PageRouteBuilder(
                          pageBuilder: (_, animation, __) => FadeTransition(
                                opacity: animation,
                                child: const MainPage(),
                              )));
                    }),
          )
        ],
      ),
    );
  }
}
