import 'package:emetrix_flutter/app/core/services/main.dart';
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
        centerTitle: false,
        backgroundColor: c.background,
        elevation: 0,
        toolbarHeight: size.height * 0.1,
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 0),
        children: [
          ListTile(
            title: Text('Capacitaciones', style: t.medium),
            onTap: () {},
            trailing: const Icon(Icons.arrow_forward_ios, size: 18),
            leading: const Icon(Icons.info),
            minLeadingWidth: 25,
          ),
          ListTile(
            title: Text('FAQs', style: t.medium),
            onTap: () {},
            trailing: const Icon(Icons.arrow_forward_ios, size: 18),
            leading: const Icon(Icons.question_answer),
            minLeadingWidth: 25,
          ),
          ListTile(
            title: Text('Soporte Técnico', style: t.medium),
            onTap: () {},
            trailing: const Icon(Icons.arrow_forward_ios, size: 18),
            leading: const Icon(Icons.contact_support),
            minLeadingWidth: 25,
          ),
          ListTile(
            title: Text('Cerrar Sesión', style: t.medium),
            onTap: () => showModal(size),
            trailing: const Icon(Icons.arrow_forward_ios, size: 18),
            leading: const Icon(Icons.exit_to_app),
            minLeadingWidth: 25,
          ),
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
