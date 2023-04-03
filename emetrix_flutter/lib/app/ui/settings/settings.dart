import 'package:emetrix_flutter/app/ui/login/login.dart';
import 'package:emetrix_flutter/app/ui/main/controller.dart';
import 'package:emetrix_flutter/app/ui/utils/colors.dart';
import 'package:emetrix_flutter/app/ui/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Ajustes', style: t.titleBlue),
      ),
      body: Column(
        children: [
          // Expanded(
          //     child: Container(
          //         color: Colors.transparent,
          //         child: Padding(
          //           padding: EdgeInsets.only(
          //               left: size.height * 0.018, top: size.height * 0.03),
          //           child: Align(
          //               alignment: Alignment.centerLeft,
          //               child: Text('Ajustes', style: t.titleBlue)),
          //         ))),
          ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 0),
            children: [
              ListTile(
                title: Text('Capacitaciones', style: t.medium),
                onTap: () {},
                trailing: Icon(Icons.info, color: c.primary),
              ),
              ListTile(
                title: Text('FAQs', style: t.medium),
                onTap: () {},
                trailing: Icon(Icons.question_answer, color: c.primary),
              ),
              ListTile(
                title: Text('Soporte Técnico', style: t.medium),
                onTap: () {},
                trailing: Icon(Icons.contact_support, color: c.primary),
              ),
              ListTile(
                title: Text('Cerrar Sesión', style: t.medium),
                onTap: () => showModal(size),
                trailing: Icon(Icons.exit_to_app, color: c.error),
              ),
            ],
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
                padding: EdgeInsets.all(size.height * 0.01),
                child: Text('¿Seguro que quieres cerrar la sesión?',
                    style: t.medium),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: size.height * 0.01),
                child: ListTile(
                    title: Text('Cerrar Sesión',
                        style: t.textError, textAlign: TextAlign.center),
                    onTap: closeSession),
              )
            ],
          );
        });
  }

  Future closeSession() async {
    //Borrar toda la info guardada y set to Default
    final navigator = Navigator.of(context);
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('loginInfo');
    prefs.remove('routes');
    prefs.remove('storesData');
    ref.read(mainIndex.notifier).setIndex(0);
    //
    setState(() {});
    navigator.pushAndRemoveUntil(MaterialPageRoute(builder: (context) {
      return const LoginPage();
    }), (route) => false);
  }

  //
}
