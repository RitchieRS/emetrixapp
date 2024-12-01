import 'package:emetrix_flutter/app/core/services/services.dart';
import 'widgets/page_custom.dart';

final onboardingPages = [
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
