import 'package:emetrix_flutter/app/ui/route%20of%20the%20day/route_of_the_day.dart';
import 'package:emetrix_flutter/app/ui/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyDrawer extends ConsumerStatefulWidget {
  const MyDrawer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyDrawerState();
}

class _MyDrawerState extends ConsumerState<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.transparent),
            child: CircleAvatar(
                backgroundColor: Colors.blue[700],
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Image.asset('assets/images/logo_blancoE.png'),
                )),
          ),
          ListTile(
            title: const Text('Ruta del Dia'),
            leading: Icon(Icons.route, color: c.primary),
            onTap: () {
              Scaffold.of(context).closeDrawer();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RouteOfTheDayPage()));
            },
          ),
          ListTile(
            title: const Text('Actividades Adicionales'),
            leading: Icon(Icons.task_outlined, color: c.primary),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Pendientes'),
            leading: Icon(Icons.pending_actions, color: c.primary),
            onTap: () {},
          ),
          ListTile(
            title: const Text('KPIs'),
            leading: Icon(Icons.workspace_premium, color: c.primary),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Tareas'),
            leading: Icon(Icons.task, color: c.primary),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Ventas'),
            leading: Icon(Icons.monetization_on_sharp, color: c.primary),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
