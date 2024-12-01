import 'package:flutter_riverpod/flutter_riverpod.dart';

//Cada vez que se necesite cambiar la version se cambia desde aqui

const String _appVersion = '1.0.1';

final appVersionProvider = StateProvider<String>((ref) {
  return _appVersion;
});
