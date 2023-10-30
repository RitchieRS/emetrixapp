import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animate_do/animate_do.dart';

import 'package:emetrix_flutter/app/core/services/services.dart';
import 'package:emetrix_flutter/app/ui/modules/onboarding/widgets/page_custom.dart';
import 'package:emetrix_flutter/app/ui/modules/onboarding/select_theme.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final controller = PageController();
  int currentPage = 0;
  bool showStart = false;
  final pages = [
    const PageCustom(
      title: 'Bienvenido a Emetrix',
      content:
          'Gestiona los sondeos de las tiendas que visitarás con mayor simplicidad.',
      image: AppAssets.appUi,
    ),
    const PageCustom(
      title: 'UI Mejorada',
      content:
          'Disfruta de una interfaz de usuario mejorada, personalizada e intuitiva. Integrando el estandar de Diseño de Material 2.',
      image: AppAssets.appMobile,
    ),
    const PageCustom(
      title: 'Selección de tiendas',
      content:
          'Elige las tiendas que visitarás durante el dia. Estas tiendas se guardarán en tu "Ruta del dia". ',
      image: AppAssets.appSelect,
    ),
    const PageCustom(
      title: 'Selección de tiendas',
      content:
          'Despues de agregar tus tiendas, ya no necesitarás internet. Tu progreso se guardará localmente. Cuando tengas conexión estable a la red, podrás subir tus sondeos. ',
      image: AppAssets.wifi,
    ),
  ];

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (!showStart && (currentPage + 1) >= (pages.length - 0.5)) {
        setState(() {
          showStart = true;
        });
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: c.surface,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: c.surface,
            statusBarIconBrightness: Brightness.dark),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeIn(
            delay: const Duration(seconds: 1),
            child: Padding(
              padding: EdgeInsets.only(right: size.width * 0.05),
              child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {
                        if (currentPage + 1 == pages.length) {
                          return;
                        }
                        controller.animateToPage(
                            curve: Curves.easeIn,
                            duration: const Duration(milliseconds: 500),
                            pages.length);
                      },
                      child: Text('Saltar', style: t.mediumBold))),
            ),
          ),
          FadeIn(
            delay: const Duration(seconds: 1),
            child: SizedBox(
              height: size.height * 0.6,
              width: size.width,
              child: PageView.builder(
                controller: controller,
                physics: const BouncingScrollPhysics(),
                itemCount: pages.length,
                itemBuilder: (context, index) => pages[index],
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
              ),
            ),
          ),
          FadeInDown(
            child: Padding(
              padding: EdgeInsets.only(left: size.width * 0.04),
              child: SizedBox(
                height: size.height * 0.1,
                width: size.width * 0.3,
                child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        SizedBox(width: size.width * 0.05),
                    shrinkWrap: true,
                    itemCount: pages.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        height: size.height * 0.008,
                        width: size.height * 0.008,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: currentPage == index
                                ? c.primary500
                                : c.primary500.withOpacity(0.2)),
                      );
                    }),
              ),
            ),
          ),
          // currentPage + 1 == pages.length
          showStart
              ? FadeIn(
                  delay: const Duration(seconds: 1),
                  child: ButonDimentions(
                      background: c.primary500,
                      title: 'Comenzar',
                      style: t.mediumLight,
                      onTap: () => Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                              pageBuilder: (_, animation, __) => FadeTransition(
                                    opacity: animation,
                                    child: const SelectThemePage(),
                                  ))),
                      width: size.width * 0.85,
                      height: size.height * 0.065),
                )
              : SizedBox(height: size.height * 0.065)
        ],
      ),
    );
  }
}
