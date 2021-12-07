import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:insidersapp/src/pages/login/form_models/phone_entity.dart';
import 'package:insidersapp/src/repositories/local/secure_storage/secure_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late final SecureStorageRepository _secureRepository;

  static Widget injectNewBloc({
    required Widget child,
  }) {
    /// this auto closes
    return BlocProvider<AuthBloc>(
      create: (BuildContext context) => AuthBloc(),
      child: child,
    );
  }

  Widget injectBloc({required Widget child}) {
    return BlocProvider<AuthBloc>.value(
      value: this,
      child: child,
    );
  }

  AuthBloc() : super(const AuthUninitialized()) {
    _secureRepository = GetIt.I.get<SecureStorageRepository>();

    on<AppStarted>((event, emit) async {
      await _appStarted(event, emit);
    });

    on<LoggedIn>((event, emit) async {
      await _loggedIn(event, emit);
    });
    on<LoggedOut>((event, emit) async {
      await _loggedOut(event, emit);
    });
    on<UserDeleted>((event, emit) async {
      await _userDeleted(event, emit);
    });
  }

  void setAppStarted() {
    add(const AuthEvent.appStarted());
  }

  void setLoggedOut() {
    add(const AuthEvent.loggedOut());
  }

  void setUserDeleted() {
    add(const AuthEvent.userDeleted());
  }

  Future<void> _appStarted(
    AuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    await _cleanIfFirstUseAfterUninstall();
    await _initStartup(event, emit);
  }

  Future<void> _initStartup(
    AuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    final hasToken = await _secureRepository.hasToken();

    if (!hasToken) {
      emit(const AuthUnauthenticated());
    } else {
      emit(const AuthAuthenticated());
    }
  }

  void setLoggedIn({
    required PhoneEntity phone,
    required String token,
    int expiresIn = 0,
    String? error,
  }) {
    add(AuthEvent.loggedIn(
      phone: phone,
      token: token,
      expiresIn: expiresIn,
      error: error,
    ));
  }

  Future<void> _loggedIn(
    LoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    await _secureRepository.persistPhoneAndToken(
      phone: event.phone,
      token: event.token,
    );
    await _initStartup(event, emit);
  }

  Future<void> _loggedOut(
    LoggedOut event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoggingOut());
    await _secureRepository.deleteToken();
    emit(const AuthLoggedOut());
  }

  Future<void> _userDeleted(
    AuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    await _secureRepository.deleteAll();
    emit(const AuthUnauthenticated());
  }

  Future<void> _cleanIfFirstUseAfterUninstall() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getBool('first_run') ?? true) {
      await _secureRepository.deleteAll();
      await prefs.setBool('first_run', false);
    }
  }
}
