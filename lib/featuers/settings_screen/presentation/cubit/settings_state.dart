part of 'settings_cubit.dart';

enum SettingsStatus { initial, loading, success, error }

@immutable
class SettingsState {
  SettingsStatus? settingsStatus;
  Color? primaryColor;
  int? index;
  bool isAutoTheme;
  String language;

  SettingsState(
      {this.settingsStatus,
      this.primaryColor,
      this.index,
      this.language = 'en',
      this.isAutoTheme = false});

  SettingsState copyWith(
      {SettingsStatus? settingsStatus,
      bool? isAutoTheme,
        String ? language,
      Color? primaryColor,
      int? index}) {
    return SettingsState(
      language: language ?? this.language,
        index: index ?? this.index,
        isAutoTheme: isAutoTheme ?? this.isAutoTheme,
        settingsStatus: settingsStatus ?? this.settingsStatus,
        primaryColor: primaryColor ?? this.primaryColor);
  }
}

final class SettingsInitial extends SettingsState {
  SettingsInitial()
      : super(
            settingsStatus: SettingsStatus.initial,
            primaryColor: greenPrimaryColor);
}
