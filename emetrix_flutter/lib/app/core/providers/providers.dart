import 'package:emetrix_flutter/app/core/login/repository.dart';
import 'package:emetrix_flutter/app/core/login/service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginRepoProvider = Provider<LoginRepository>((ref) {
  return LoginRepository();
});

final loginServiceProvider = Provider<LoginService>((ref) {
  final respository = ref.watch(loginRepoProvider);
  return LoginService(respository);
});
