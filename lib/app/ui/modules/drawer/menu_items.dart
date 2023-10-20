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

List<MenuItem> appMenuItems = [
  const MenuItem(
      title: 'Fuera de Ruta',
      subtitle: 'Fuera de Ruta',
      link: 'OFroute',
      icon: Icon(Icons.route)),
  // const MenuItem(
  //     title: 'Actividades Adicionales',
  //     subtitle: 'Actividades Adicionales',
  //     link: 'aditionalAct',
  //     icon: Icon(Icons.task_outlined)),
  // const MenuItem(
  //     title: 'Pendientes',
  //     subtitle: 'Pendientes',
  //     link: 'pendings',
  //     icon: Icon(Icons.pending_actions)),
  // const MenuItem(
  //   title: 'Tareas',
  //   subtitle: 'Tareas',
  //   link: '',
  //   icon: Icon(Icons.task),
  // ),
  // const MenuItem(
  //     title: 'KPIs',
  //     subtitle: 'KPIs',
  //     link: '',
  //     icon: Icon(Icons.workspace_premium)),
  // const MenuItem(
  //     title: 'Ventas',
  //     subtitle: 'Ventas',
  //     link: '',
  //     icon: Icon(Icons.monetization_on_sharp)),
];
