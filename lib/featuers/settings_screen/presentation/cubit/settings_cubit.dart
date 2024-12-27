import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../config/themes/themes.dart';
import '../../../../core/shared_preference/shared_preferences_manager.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_constants.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());

  static SettingsCubit get(BuildContext context) => BlocProvider.of(context);

  void initApp({required int themeIndex,
    required bool isAutoThemeActive,
    required String language}) {
    emit(state.copyWith(
        primaryColor: colors[themeIndex],
        index: themeIndex,
        isAutoTheme: isAutoThemeActive,
        language: language));
  }

  void changePrimaryColor(int index) async {
    lightTheme = lightTheme.copyWith(
        appBarTheme: lightTheme.appBarTheme.copyWith(
          backgroundColor: colors[index],
        ),
        textSelectionTheme: TextSelectionThemeData(
            selectionColor: colors[index].withOpacity(.5),
            selectionHandleColor: colors[index]),
        colorScheme: lightTheme.colorScheme.copyWith(primary: colors[index]));
    emit(state.copyWith(primaryColor: colors[index], index: index));
    await SharedPreferencesManager.setInt("themeIndex", index);
  }

  void changeAutoTheme(bool value) async {
    emit(state.copyWith(isAutoTheme: value));
    await SharedPreferencesManager.setBool("isAutoThemeActive", value);
  }

  void changeLanguage(String? language) async {
    emit(state.copyWith(language: language));
    await SharedPreferencesManager.setString(
        "local", language ?? state.language);
  }
}
