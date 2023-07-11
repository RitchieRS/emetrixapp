import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:emetrix_flutter/app/core/services/theme/theme.dart';
import 'package:emetrix_flutter/app/ui/modules/sondeo/controller.dart';
import 'package:emetrix_flutter/app/ui/global/ui.dart';
import 'package:emetrix_flutter/app/ui/main/controller.dart';
import 'package:emetrix_flutter/app/ui/modules/login/login.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Ajustes', style: t.titleBlue),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        toolbarHeight: size.height * 0.1,
        systemOverlayStyle: isDark == ThemeMode.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
        actions: [
          IconButton(
              onPressed: () {
                ref.read(themeProvider.notifier).toggleTheme();
                setState(() {});
              },
              icon: isDark == ThemeMode.dark
                  ? const Icon(Icons.dark_mode_outlined)
                  : Icon(Icons.light_mode, color: c.disabled))
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        // padding: const EdgeInsets.only(top: 0),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Container(
                width: size.width * 0.9,
                decoration: BoxDecoration(
                  color: Theme.of(context).highlightColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(children: [
                  ListTile(
                    title: Text('Capacitaciones', style: t.mediumBold),
                    subtitle: Text('Cursos para ti.', style: t.text),
                    onTap: () {},
                    trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                    leading: const Icon(Icons.info),
                    minLeadingWidth: 25,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  ListTile(
                    title: Text('FAQs', style: t.mediumBold),
                    subtitle: Text('Preguntas frecuentes.', style: t.text),
                    onTap: () {},
                    trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                    leading: const Icon(Icons.question_answer),
                    minLeadingWidth: 25,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  ListTile(
                    title: Text('Soporte Técnico', style: t.mediumBold),
                    subtitle: Text('Contáctanos.', style: t.text),
                    onTap: () {},
                    trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                    leading: const Icon(Icons.contact_support),
                    minLeadingWidth: 25,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                ]),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.02),
            child: Center(
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        foregroundColor: c.error,
                        minimumSize:
                            Size(size.width * 0.9, size.height * 0.06)),
                    onPressed: () => showModal(size, isDark),
                    child: Text('Cerrar Sesión', style: t.mediumBold))),
          )
        ],
      ),
    );
  }

  void showModal(Size size, ThemeMode isDark) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14), topRight: Radius.circular(14))),
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: size.height * 0.02, bottom: size.height * 0.01),
                child: Text('Cuidado', style: t.subtitle2),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.height * 0.03),
                child: Text(
                    'Ten en cuenta que se borrará todo tu progreso guardado en tu teléfono hasta el momento. \nIncluyendo: \n - Rutas del dia. \n - Actividades adicionales.\n - Sondeos. ',
                    style: t.medium),
              ),
              Padding(
                padding: EdgeInsets.all(size.height * 0.02),
                child: Text('¿Seguro que quieres cerrar la sesión?',
                    style: t.medium),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: size.height * 0.03),
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        foregroundColor: c.error,
                        minimumSize:
                            Size(size.width * 0.9, size.height * 0.06)),
                    onPressed: () => closeSession(isDark),
                    child: Text('Cerrar Sesión', style: t.textError)),
              )
            ],
          );
        });
  }

  Future closeSession(ThemeMode isDark) async {
    //Borrar toda la info guardada y set to Default
    final navigator = Navigator.of(context);

    showProgress(context: context, title: 'Cerrando Sesion');
    await Future.delayed(const Duration(seconds: 1));
    navigator.pop();
    // Navigator.of(context, rootNavigator: true).pop();

    final prefs = await SharedPreferences.getInstance();
    ref.read(mainIndex.notifier).setIndex(0);
    ref.read(currentOptionProvider.notifier).update((state) => 0);

    if (isDark == ThemeMode.dark) {
      await ref.read(themeProvider.notifier).setLightTheme();
    }

    await prefs.clear().whenComplete(() async {
      setState(() {});
      await vibrate();
      navigator.pushAndRemoveUntil(MaterialPageRoute(builder: (context) {
        return const LoginPage();
      }), (route) => false);
    });
    //S
  }

  //
}
