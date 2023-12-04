

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

final textEditingControllerProvider = ProviderFamily<TextEditingController, int>((ref, index) {
  return TextEditingController();
});

final textControllerListProvider = Provider<List<int>>((ref) {
  return [];
});