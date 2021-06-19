import 'package:attendance/screen/root_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'infrastructure/implementations/absent_repository_impl.dart';
import 'infrastructure/implementations/auth_repository_impl.dart';
import 'infrastructure/repositories/absent_repository.dart';
import 'infrastructure/repositories/auth_repository.dart';

void main() {
  setupServiceLocator();
  runApp(RootScreen());
}

void setupServiceLocator() {
  GetIt.I.registerFactory<AuthRepository>(() => AuthRepositoryImpl());
  GetIt.I.registerFactory<AbsentRepository>(() => AbsentRepositoryImpl());
}
