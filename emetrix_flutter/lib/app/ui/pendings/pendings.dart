import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PendingsPage extends ConsumerStatefulWidget {
  const PendingsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PendingsPageState();
}

class _PendingsPageState extends ConsumerState<PendingsPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return const Scaffold(
      body: Center(child: Text('Pendings')),
    );
  }
}
