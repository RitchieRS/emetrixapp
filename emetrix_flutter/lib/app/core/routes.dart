import 'package:emetrix_flutter/app/ui/addActivities/aditional_activities.dart';
import 'package:emetrix_flutter/app/ui/main/main_screen.dart';
import 'package:emetrix_flutter/app/ui/outOfRoute/out_of_route.dart';
import 'package:emetrix_flutter/app/ui/pendings/pendings.dart';
import 'package:emetrix_flutter/app/ui/route%20of%20the%20day/route_of_the_day.dart';
import 'package:emetrix_flutter/app/ui/settings/settings.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getAppRoutes() {
  return {
    'home': (context) => const MainPage(),
    'routeOTD': (context) => const RouteOfTheDayPage(),
    'OFroute': (context) => const OutOfRoutePage(),
    'aditionalAct': (context) => const AditionalActivitiesPage(),
    'pendings': (context) => const PendingsPage(),
    'settings': (context) => const SettingsPage(),
  };
}
