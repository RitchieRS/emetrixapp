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
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Image.asset('assets/images/logo_blancoE.png'),
            ),
          )),
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
            title: const Text('SKUs'),
            leading: const Icon(Icons.workspace_premium),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
