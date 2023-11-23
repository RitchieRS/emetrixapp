import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:emetrix_flutter/app/core/global/app_info.dart';
import 'package:emetrix_flutter/app/core/services/assets/assets.dart';
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
  final List<Item> items = [
    Item(
        title: 'Capacitaciones',
        subtitle: 'Cursos para ti.',
        icon: Icons.info,
        route: ''),
    Item(
        title: 'FAQs',
        subtitle: 'Preguntas frecuentes.',
        icon: Icons.question_answer,
        route: ''),
    Item(
        title: 'Soporte Técnico',
        subtitle: 'Contáctanos.',
        icon: Icons.contact_support,
        route: 'support'),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = ref.watch(themeProvider) == ThemeMode.dark;
    final version = ref.watch(appVersionProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Ajustes', style: isDark ? t.titleWhite : t.titleBlack),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        toolbarHeight: size.height * 0.1,
        systemOverlayStyle:
            isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
        actions: [
          IconButton(
              onPressed: () {
                ref.read(themeProvider.notifier).toggleTheme();
                setState(() {});
              },
              icon: isDark
                  ? const Icon(Icons.dark_mode_outlined)
                  : Icon(Icons.light_mode, color: c.disabled))
        ],
      ),
      body: ListView(
        children: [
          Center(
            child: Container(
                width: size.width * 0.9,
                decoration: BoxDecoration(
                  color: Theme.of(context).highlightColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];

                      return ListTile(
                        title: Text(item.title, style: t.mediumBold),
                        subtitle: Text(item.subtitle, style: t.text),
                        onTap: () {
                          if (item.route.isEmpty) return;
                          Navigator.pushNamed(context, item.route);
                        },
                        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                        leading: Icon(items[index].icon),
                        minLeadingWidth: 25,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                      );
                    })),
          ),
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.02),
            child: Center(
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        enableFeedback: true,
                        side: BorderSide(color: c.error),
                        foregroundColor: c.error,
                        minimumSize:
                            Size(size.width * 0.9, size.height * 0.052)),
                    onPressed: () => showModal(size, isDark),
                    child: Text('Cerrar Sesión', style: t.mediumBold))),
          ),
          // const Spacer(),
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.38),
            child: GestureDetector(
              onTap: () => _showAppInfo(context, version),
              child: Center(
                  child: Text('versión: $version', style: t.textDisabled)),
            ),
          )
        ],
      ),
    );
  }

  void _showAppInfo(BuildContext context, String version) {
    showAboutDialog(
      context: context,
      applicationIcon: Material(
          color: c.primary400,
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(AppAssets.logo, height: 80)),
      applicationLegalese: '',
      applicationName: 'Emetrix',
      applicationVersion: version,
    );
  }

  void showModal(Size size, bool isDark) {
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
                child: Text('Precaución', style: t.subtitle2),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.height * 0.03),
                child: Text(
                    'Borraremos tu sesión activa de este dispositivo.\nNo te preocupes, tu información no se borrará. ',
                    style: t.medium),
              ),
              Padding(
                padding: EdgeInsets.all(size.height * 0.01),
                child: Text('¿Continuar?', style: t.medium),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: size.height * 0.03),
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        foregroundColor: c.error,
                        minimumSize:
                            Size(size.width * 0.9, size.height * 0.052)),
                    onPressed: () => closeSession(isDark),
                    child: Text('Cerrar Sesión', style: t.textError)),
              )
            ],
          );
        });
  }

  Future closeSession(bool isDark) async {
    final navigator = Navigator.of(context);
    navigator.pop();
    showProgress(context: context, title: 'Cerrando Sesión');
    await Future.delayed(const Duration(seconds: 2));

    final prefs = await SharedPreferences.getInstance();
    ref.read(mainIndex.notifier).setIndex(0);
    ref.read(currentOptionProvider.notifier).update((state) => 0);

    if (isDark) {
      await ref.read(themeProvider.notifier).setLightTheme();
    }
    //Borrar toda la info guardada en shared y set to Default
    //Excepto "loginInfo"
    //Excepto "sondeos"
    await prefs.remove('sesionStarted');
    await prefs.remove('isDarkMode');

    //await ref.read(databaseProvider).clearDatabase();
    await vibrate();
    navigator.pushAndRemoveUntil(MaterialPageRoute(builder: (context) {
      return const LoginPage();
    }), (route) => false);
    //S
  }

  //
}

final class Item {
  Item({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.route,
  });
  final String title;
  final String subtitle;
  final IconData icon;
  final String route;
}
