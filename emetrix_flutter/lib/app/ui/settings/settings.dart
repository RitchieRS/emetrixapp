import 'package:emetrix_flutter/app/ui/login/login.dart';
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(child: Text('Settings')),
          ListTile(
            title: const Text('Cerrar Sesión'),
            onTap: () => showModal(size),
            trailing: const Icon(Icons.exit_to_app),
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
                child: const Text('¿Seguro que quieres cerrar la sesión?'),
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
    final navigator = Navigator.of(context);
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('loginInfo');
    setState(() {});
    navigator.pushAndRemoveUntil(MaterialPageRoute(builder: (context) {
      return const LoginPage();
    }), (route) => false);
  }

  //
}
