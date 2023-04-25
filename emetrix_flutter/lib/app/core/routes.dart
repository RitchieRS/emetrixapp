import 'package:flutter/material.dart';

import 'package:emetrix_flutter/app/ui/main/main_screen.dart';
import 'package:emetrix_flutter/app/ui/modules/out_of_route/out_of_route.dart';
import 'package:emetrix_flutter/app/ui/modules/add_activities/aditional_activities.dart';
import 'package:emetrix_flutter/app/ui/modules/route_of_the_day/route_of_the_day.dart';
import 'package:emetrix_flutter/app/ui/modules/pendings/pendings.dart';
import 'package:emetrix_flutter/app/ui/modules/select_theme/select_theme.dart';
import 'package:emetrix_flutter/app/ui/modules/settings/settings.dart';

Map<String, WidgetBuilder> appRoutes() {
  return {
    'home': (context) => const MainPage(),
    'routeOTD': (context) => const RouteOfTheDayPage(),
    'OFroute': (context) => const OutOfRoutePage(),
    'aditionalAct': (context) => const AditionalActivitiesPage(),
    'pendings': (context) => const PendingsPage(),
    'settings': (context) => const SettingsPage(),
    'theme': (context) => const SelectTheme(),
  };
}
