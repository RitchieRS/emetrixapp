import 'package:emetrix_flutter/app/ui/route%20of%20the%20day/route_of_the_day.dart';
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
      child: ListView(
        children: [
          DrawerHeader(
              child: CircleAvatar(
            backgroundColor: Colors.blue[700],
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Image.asset('assets/images/logo_blancoE.png'),
            ),
          )),
          ListTile(
            title: const Text('Ruta del Dia'),
            leading: const Icon(Icons.route),
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
            leading: const Icon(Icons.task_outlined),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Pendientes'),
            leading: const Icon(Icons.pending_actions),
            onTap: () {},
          ),
          ListTile(
            title: const Text('KPIs'),
            leading: const Icon(Icons.workspace_premium),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Tareas'),
            leading: const Icon(Icons.task),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Ventas'),
            leading: const Icon(Icons.monetization_on_sharp),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
