import 'package:emetrix_flutter/app/core/sondeo/repository.dart';
import 'package:emetrix_flutter/app/core/sondeo/service.dart';
import 'package:emetrix_flutter/app/core/login/repository.dart';
import 'package:emetrix_flutter/app/core/login/service.dart';
import 'package:emetrix_flutter/app/core/stores/repository.dart';
import 'package:emetrix_flutter/app/core/stores/service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginRepoProvider = Provider<LoginRepository>((ref) {
  return LoginRepository();
});

final loginServiceProvider = Provider<LoginService>((ref) {
  final respository = ref.watch(loginRepoProvider);
  return LoginService(respository);
});

//-----------------------------------

final sondeoRepoProvider = Provider<HomeRepository>((ref) {
  return HomeRepository();
});

final sondeoServiceProvider = Provider<HomeService>((ref) {
  final respository = ref.watch(sondeoRepoProvider);
  return HomeService(respository);
});

//-----------------------------------

final storesRepoProvider = Provider<StoresRepository>((ref) {
  return StoresRepository();
});

final storesServiceProvider = Provider<StoresService>((ref) {
  final respository = ref.watch(storesRepoProvider);
  return StoresService(respository);
});
