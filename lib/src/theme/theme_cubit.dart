import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

@immutable
class ThemeState extends Equatable {
  final ThemeMode themeMode;

  const ThemeState(this.themeMode);

  @override
  List<Object?> get props => [themeMode];
}

class ThemeCubit extends HydratedCubit<ThemeState> {
  ThemeCubit() : super(const ThemeState(ThemeMode.dark));

  void setDark() {
    emit(const ThemeState(ThemeMode.dark));
  }

  void setLight() {
    emit(const ThemeState(ThemeMode.light));
  }

  ThemeMode getThemeMode() {
    return state.themeMode;
  }

  void setThemeMode(ThemeMode? themeMode) {
    if (themeMode == null) {
      return;
    }
    emit(ThemeState(themeMode));
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    return json['isDark'] as bool
        ? const ThemeState(ThemeMode.dark)
        : const ThemeState(ThemeMode.light);
  }

  @override
  Map<String, bool>? toJson(ThemeState state) {
    return {'isDark': state.themeMode == ThemeMode.dark};
  }
}
