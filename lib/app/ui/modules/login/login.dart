// ignore_for_file: use_build_context_synchronously
import 'package:emetrix_flutter/app/core/global/core.dart';
import 'package:emetrix_flutter/app/core/services/database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:emetrix_flutter/app/core/modules/stores/stores.dart';
import 'package:emetrix_flutter/app/ui/global/ui.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';
import 'controller.dart';
import 'widgets/back_image.dart';
import 'widgets/my_text_field.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final user = TextEditingController();
  final password = TextEditingController();
  final userKey = GlobalKey<FormState>();
  final passKey = GlobalKey<FormState>();
  bool obscurePassword = true;
  bool switchButton = false;
  final appbar = AppBar(
    backgroundColor: c.surface,
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: c.surface, statusBarIconBrightness: Brightness.dark),
  );

  @override
  void dispose() {
    user.dispose();
    userKey.currentState?.dispose();
    password.dispose();
    passKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width * 0.9;
    final height = size.height * 0.06;
    final textPadding =
        EdgeInsets.only(top: size.height * 0.01, left: size.width * 0.07);
    final buttonPadding = EdgeInsets.only(top: size.height * 0.05);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appbar,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Stack(
          children: [
            //Imagen
            const BackImage(),

            //Form
            FadeInUp(
              child: Padding(
                padding: EdgeInsets.only(top: size.height * 0.3),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Opacity(
                      opacity: 0.7,
                      child: Align(
                          alignment: Alignment.center,
                          child: Text('Inicia Sesión', style: t.title)),
                    ),
                    //
                    Padding(
                        padding: textPadding,
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Usuario', style: t.text2))),
                    TxtField(
                      hinText: 'Ingresa usuario',
                      controller: user,
                      isPassword: false,
                      formKey: userKey,
                    ),

                    Padding(
                        padding: textPadding,
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Contraseña', style: t.text2))),
                    TxtField(
                      hinText: 'Ingresa contraseña',
                      controller: password,
                      isPassword: true,
                      formKey: passKey,
                    ),

                    switchButton == false
                        ? Padding(
                            padding: buttonPadding,
                            child: ButonDimentions(
                                background: c.primary500,
                                title: 'Entrar',
                                style: t.mediumLight,
                                onTap: () => _start(),
                                width: width,
                                height: height))
                        : Padding(
                            padding: buttonPadding,
                            child: const Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          )

                    //
                  ],
                ),
              ),
            ),

            //
          ],
        ),
      ),
    );
  }

  Future<void> _start() async {
    final networkResult = await (Connectivity().checkConnectivity());
    setState(() => switchButton = !switchButton);

    if (!_validateForm(userKey.currentState) &&
        !_validateForm(passKey.currentState)) {
      setState(() {});
      return;
    }

    if (!_validateForm(userKey.currentState) ||
        !_validateForm(passKey.currentState)) {
      setState(() {});
      return;
    }

    if (networkResult == ConnectivityResult.none) {
      showYesNoMsj(
          context: context,
          title: 'Sin Conexión',
          content:
              'Conéctate a internet para poder iniciar sesión correctamente.',
          yesOnly: true);
      setState(() => switchButton = false);
      return;
    }

    await _requestAccess();
    //
  }

  bool _validateForm(FormState? form) {
    if (form != null) {
      if (form.validate()) {
        //Form is valid
        setState(() {});
        return true;
      } else {
        //Form is invalid
        setState(() {});
        setState(() => switchButton = false);
        return false;
      }
    }
    return false;
  }

  Future<void> _requestAccess() async {
    final prefs = await SharedPreferences.getInstance();
    final firstTime = prefs.containsKey('firstTimeLogging');
    final navigator = Navigator.of(context);

    bool loginSucces = await ref
        .read(loginControllerProvider.notifier)
        .sendRequest(user.text, password.text);

    if (loginSucces == true && firstTime == false) {
      await prefs.setBool('firstTimeLogging', false);
      await _verifyDatabase();
      await vibrate();
      navigator.pushReplacementNamed('onboard');
      user.clear();
      password.clear();
      setState(() => switchButton = false);
      return;
    }
    if (loginSucces == true && firstTime == true) {
      await _verifyDatabase();
      navigator.pushReplacementNamed('home'); //home
      user.clear();
      password.clear();
      setState(() => switchButton = false);
      await vibrate();
      return;
    }
    await Future.delayed(const Duration(seconds: 1)).whenComplete(() {
      setState(() => switchButton = false);
      user.clear();
      password.clear();
      showYesNoMsj(
          context: context,
          title: 'Error',
          content: 'El usuario y la contraseña no existen. Intentalo de nuevo.',
          yesOnly: true);
    });
  }

  Future<void> _verifyDatabase() async {
    final products = await ref.read(databaseProvider).isProductsEmpty();
    final stores = await ref.read(databaseProvider).isStoreGeneralsEmpty();
    if (stores) {
      await _getStores();
    }else{
      _getUpdateStores();
    }
    if(products){
      await _getProducts();
    }
  }

  Future<void> _getStores() async {
    List<Store> allStores = [];
    final stores = await ref.read(loginControllerProvider.notifier).getStores();
    final storesAdditional =
        await ref.read(loginControllerProvider.notifier).getAditionalStores();

    stores.resp?.forEach((store) {
      allStores.add(store);
    });
    storesAdditional.resp?.forEach((store) {
      allStores.add(store);
    });

    await ref
        .read(loginControllerProvider.notifier)
        .saveStoresData(allStores, ref);
  }

   Future<void> _getUpdateStores() async {
    List<Store> allStores = [];
    final storesfromsrv = await ref.read(loginControllerProvider.notifier).getStores();
    var storesfromdb =
        await ref.read(loginControllerProvider.notifier).getAllStoresFromDB();

    /*stores.resp?.forEach((store) {
      if(store.)
      allStores.add(store);
    });*/

    for(Stores storefdb in storesfromdb){
      for(Store store in storefdb.resp!.toList()){
         storesfromsrv.resp?.forEach((storesrv) {
            if(store.id == storesrv.id){
              if(store.checkGPS !=  storesrv.checkGPS){
                 store.checkGPS = storesrv.checkGPS;
                 allStores.add(store);
                 }
           }else{
            allStores.add(storesrv);
           }
    });
           
      }
    }
    try{
    await ref.read(databaseProvider).clearStores();
    await ref
        .read(loginControllerProvider.notifier)
        .saveStoresData(allStores, ref);
    }catch(e){
      logger.e(e);
    }
  }

  Future<void> _getProducts() async {
    final products =
        await ref.read(loginControllerProvider.notifier).getProductsCtrl();
    await ref
        .read(loginControllerProvider.notifier)
        .saveProductsData(products.resp.productos, ref);
  }
}
