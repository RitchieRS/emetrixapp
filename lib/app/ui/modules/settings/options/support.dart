import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:animate_do/animate_do.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:emetrix_flutter/app/core/modules/login/login.dart';
import 'package:emetrix_flutter/app/core/services/services.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class SupportPage extends ConsumerStatefulWidget {
  const SupportPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SupportPageState();
}

class _SupportPageState extends ConsumerState<SupportPage> {
  Resp? userInfo;
  List<String> emails = [];
  List<String> phones = [];

  @override
  void initState() {
    _getUserInfo().whenComplete(() {
      _separatePhone();
      _separateEmail();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final horizontalPadding = size.width * 0.06;
    final Widget image = SvgPicture.asset(
      AppAssets.contactUs,
      height: size.height * 0.2,
      fit: BoxFit.cover,
    );

    return Scaffold(
      appBar: const GeneralTitle(title: 'Soporte Técnico'),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
            child: Center(
              child: FadeIn(child: image),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('¿Necesitas Ayuda?',
                    style: t.subtitle, textAlign: TextAlign.left),
                Text(
                    'Si tienes algún problema con la app, no te preocupes. Tenemos un equipo de soporte técnico que está disponible para ayudarte.',
                    style: t.text2,
                    textAlign: TextAlign.left),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: const Text('\nCorreo:'),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: emails.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                      icon: const Icon(Icons.copy, size: 15),
                      onPressed: () => _copyText(emails[index]),
                      label: Text(emails[index]))),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: const Text('\nTelefono:'),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: emails.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                      icon: const Icon(Icons.copy, size: 15),
                      onPressed: () => _copyText(phones[index]),
                      label: Text(phones[index]))),
            ),
          ),
        ],
      ),
    );
  }

  void _copyText(String text) async {
    ref.read(messagesProvider).showSuccess(
        context: context,
        message: 'Copiado',
        duration: const Duration(milliseconds: 400));
    await Clipboard.setData(ClipboardData(text: text));
  }

  void _separateEmail() {
    final String tempList = userInfo?.usuario.correosSoporte
            .substring(8, userInfo?.usuario.correosSoporte.length) ??
        '';
    emails = tempList.split('#');
    setState(() {});
  }

  void _separatePhone() {
    final String tempList = userInfo?.usuario.telefonosSoporte
            .substring(8, userInfo?.usuario.telefonosSoporte.length) ??
        '';
    phones = tempList.split('#');
    setState(() {});
  }

  Future<void> _getUserInfo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final info = prefs.getString('loginInfo');
      userInfo = Resp.fromRawJson(info ?? '');
      setState(() {});
    } catch (error) {
      debugPrint(error.toString());
      userInfo = null;
      setState(() {});
    }
  }
}
