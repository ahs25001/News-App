import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/config/routes/routes.dart';
import 'package:news_app/config/themes/themes.dart';
import 'package:news_app/core/utils/app_colors.dart';
import 'package:news_app/featuers/settings_screen/presentation/cubit/settings_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(),
      child: BlocSelector<SettingsCubit, SettingsState, Color?>(
        selector: (state) {
          return state.primaryColor;
        },
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: const Size(412, 870),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) => MaterialApp(
              theme: lightTheme,
              debugShowCheckedModeBanner: false,
              onGenerateRoute: (settings) => Routes.onGenerateRoute(settings),
            ),
          );
        },
      ),
    );
  }
}
