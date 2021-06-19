import 'dart:async';

import 'package:attendance/infrastructure/prefs.dart';
import 'package:attendance/infrastructure/repositories/auth_repository.dart';
import 'package:attendance/screen/login_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

  AuthRepository get _repository => GetIt.I<AuthRepository>();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is CheckAuth) {
      yield AuthLoading();
      try {
        final result = await _repository.checkAuth();

        yield AuthSuccess(result);
      } catch (e) {
        yield AuthError();
      }
    }

    if (event is SignUp) {
      try {
        yield AuthLoading();
        final result = await _repository.signUp(
          event.email,
          event.password,
          event.name,
        );
        yield (AuthSuccess(result));
      } catch (e) {
        yield AuthError();
      }
    }

    if (event is SignIn) {
      try {
        yield AuthLoading();
        final result = await _repository.signIn(
          event.username,
          event.password,
        );

        String name = result.displayName;
        String resp = 'Login Success';
        yield (AuthSuccess(name));
      } catch (e) {
        yield AuthError();
      }
    }
    if (event is SignOut) {
      try {
        yield AuthLoading();
        final result = await _repository.signOut();
        String resp = 'Logout Success';
        yield (AuthSuccess(resp));
      } catch (e) {
        yield AuthError();
      }
    }
  }
}
