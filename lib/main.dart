import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/config/routes/routes.dart';
import 'package:news_app/config/themes/themes.dart';
import 'package:news_app/core/shared_preference/shared_preferences_manager.dart';
import 'package:news_app/featuers/settings_screen/presentation/cubit/settings_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'core/utils/app_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String local = await SharedPreferencesManager.getString("local") ?? "en";
  int themeIndex = await SharedPreferencesManager.getInt("themeIndex") ?? 0;
  bool isAutoThemeActive =
      await SharedPreferencesManager.getBool("isAutoThemeActive");
  // if (!isAutoThemeActive){
  //   lightTheme = lightTheme.copyWith(
  //       appBarTheme: lightTheme.appBarTheme.copyWith(
  //         backgroundColor: colors[themeIndex],
  //       ),
  //       textSelectionTheme: TextSelectionThemeData(
  //           selectionColor: colors[themeIndex].withOpacity(.5),
  //           selectionHandleColor: colors[themeIndex]),
  //       colorScheme:
  //       lightTheme.colorScheme.copyWith(primary: colors[themeIndex]));
  // }
  await ScreenUtil.ensureScreenSize();
  runApp(MyApp(
    isAutoThemeActive: isAutoThemeActive,
    local: local,
    themeIndex: themeIndex,
  ));
}

class MyApp extends StatelessWidget {
  String local;
  int themeIndex;
  bool isAutoThemeActive;

  MyApp(
      {super.key,
      required this.local,
      required this.themeIndex,
      required this.isAutoThemeActive});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit()
        ..initApp(
            language: local,
            themeIndex: themeIndex,
            isAutoThemeActive: isAutoThemeActive),
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: const Size(412, 870),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) => MaterialApp(
              locale: Locale(state.language),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              theme: isAutoThemeActive
                  ? lightTheme
                  : lightTheme.copyWith(
                      appBarTheme: lightTheme.appBarTheme.copyWith(
                        backgroundColor:
                            colors[SettingsCubit.get(context).state.index ?? 0],
                      ),
                      textSelectionTheme: TextSelectionThemeData(
                          selectionColor: colors[
                                  SettingsCubit.get(context).state.index ?? 0]
                              .withOpacity(.5),
                          selectionHandleColor: colors[
                              SettingsCubit.get(context).state.index ?? 0]),
                      colorScheme: lightTheme.colorScheme.copyWith(
                          primary: colors[
                              SettingsCubit.get(context).state.index ?? 0])),
              debugShowCheckedModeBanner: false,
              onGenerateRoute: (settings) => Routes.onGenerateRoute(settings),
            ),
          );
        },
      ),
    );
  }
}
