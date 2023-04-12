import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:emetrix_flutter/app/core/services/main.dart';
import 'package:emetrix_flutter/app/ui/login/login.dart';
import 'package:emetrix_flutter/app/ui/main/controller.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  @override
  void initState() {
    super.initState();
    Services.checkConectivity();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Ajustes', style: t.titleBlue),
        centerTitle: true,
        backgroundColor: c.background,
        elevation: 0,
        toolbarHeight: size.height * 0.1,
        actions: [
          IconButton(
              onPressed: () {}, icon: Icon(Icons.light_mode, color: c.disabled))
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 0),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Container(
                width: size.width * 0.9,
                decoration: BoxDecoration(
                  color: c.disabled.withOpacity(0.1),
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
                    onPressed: () => showModal(size),
                    child: Text('Cerrar Sesión', style: t.mediumBold))),
          )
        ],
      ),
    );
  }

  showModal(Size size) {
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
                padding: EdgeInsets.all(size.height * 0.02),
                child: Text(
                    'Ten en cuenta que se borrará todo tu progreso guardado en tu teléfono hasta el momento. \nIncluyendo: \n - Rutas del dia \n - Actividades adicionales\n - Sondeos \n etc.',
                    style: t.medium),
              ),
              Padding(
                padding: EdgeInsets.all(size.height * 0.01),
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
                    onPressed: () => closeSession(),
                    child: Text('Cerrar Sesión', style: t.textError)),
              )
            ],
          );
        });
  }

  Future closeSession() async {
    //Borrar toda la info guardada y set to Default
    final navigator = Navigator.of(context);
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('loginInfo');
    await prefs.remove('routes');
    await prefs.remove('storesData');
    await prefs.remove('sondeos');
    ref.read(mainIndex.notifier).setIndex(0);
    //
    setState(() {});
    navigator.pushAndRemoveUntil(MaterialPageRoute(builder: (context) {
      return const LoginPage();
    }), (route) => false);
  }

  //
}
