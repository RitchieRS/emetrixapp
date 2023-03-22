import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AditionalActivitiesPage extends ConsumerStatefulWidget {
  const AditionalActivitiesPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AditionalActivitiesPageState();
}

class _AditionalActivitiesPageState
    extends ConsumerState<AditionalActivitiesPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Aditional Activities'),
      ),
    );
  }
}
