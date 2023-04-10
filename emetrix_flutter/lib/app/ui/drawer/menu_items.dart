import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String subtitle;
  final String link;
  final Icon icon;

  const MenuItem({
    required this.title,
    required this.subtitle,
    required this.link,
    required this.icon,
  });
}

const appMenuItems = <MenuItem>[
  MenuItem(
      title: 'Ruta del Dia',
      subtitle: 'Ruta del Dia',
      link: 'routeOTD',
      icon: Icon(Icons.route)),
  MenuItem(
      title: 'Actividades Adicionales',
      subtitle: 'Actividades Adicionales',
      link: 'aditionalAct',
      icon: Icon(Icons.task_outlined)),
  MenuItem(
      title: 'Pendientes',
      subtitle: 'Pendientes',
      link: 'pendings',
      icon: Icon(Icons.pending_actions)),
  MenuItem(
    title: 'Tareas',
    subtitle: 'Tareas',
    link: '',
    icon: Icon(Icons.task),
  ),
  MenuItem(
      title: 'KPIs',
      subtitle: 'KPIs',
      link: '',
      icon: Icon(Icons.workspace_premium)),
  MenuItem(
      title: 'Ventas',
      subtitle: 'Ventas',
      link: '',
      icon: Icon(Icons.monetization_on_sharp)),
];
