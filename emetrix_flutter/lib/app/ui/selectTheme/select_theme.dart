import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectTheme extends ConsumerWidget {
  const SelectTheme({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        color: ThemeData().colorScheme.primary,
        child: Column(
          children: const [],
        ),
      ),
    );
  }
}
