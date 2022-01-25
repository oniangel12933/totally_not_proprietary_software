import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

@immutable
class ThemeState extends Equatable {
  final bool isDark;

  const ThemeState({required this.isDark});

  @override
  List<Object?> get props => [isDark];

  ThemeMode getMaterialThemeMode() {
    return isDark ? ThemeMode.dark : ThemeMode.light;
  }

  Brightness getCupThemeBrightness() {
    return isDark ? Brightness.dark : Brightness.light;
  }
}

class ThemeCubit extends HydratedCubit<ThemeState> {
  ThemeCubit() : super(const ThemeState(isDark: true));

  void setDark() {
    emit(const ThemeState(isDark: true));
  }

  void setLight() {
    emit(const ThemeState(isDark: false));
  }

  void setIsDark({required bool isDark}) {
    emit(ThemeState(isDark: isDark));
  }

  bool getIsDark() {
    return state.isDark;
  }

  ThemeMode getMaterialThemeMode() {
    return state.isDark ? ThemeMode.dark : ThemeMode.light;
  }

  Brightness getCupThemeBrightness() {
    return state.isDark ? Brightness.dark : Brightness.light;
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    return json['isDark'] as bool
        ? const ThemeState(isDark: true)
        : const ThemeState(isDark: false);
  }

  @override
  Map<String, bool>? toJson(ThemeState state) {
    return {'isDark': state.isDark};
  }
}
