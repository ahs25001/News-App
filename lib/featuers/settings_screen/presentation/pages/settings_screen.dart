import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/config/themes/themes.dart';
import 'package:news_app/core/utils/app_constants.dart';
import 'package:news_app/core/utils/app_strings.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/app_styles.dart';
import '../cubit/settings_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              backgroundImage,
            ),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(settings),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0.w),
              child: Text(
                themes,
                style: optionsTitleStyle,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  autoThemes,
                  style: optionsStyle.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                BlocSelector<SettingsCubit, SettingsState, bool>(
                  selector: (state) {
                    return state.isAutoTheme;
                  },
                  builder: (context, state) {
                    return Switch(
                      activeTrackColor: Colors.transparent,
                      trackOutlineColor: WidgetStateColor.resolveWith(
                        (states) {
                          return Theme.of(context).colorScheme.primary;
                        },
                      ),
                      activeColor: Theme.of(context).colorScheme.primary,
                      value: state,
                      onChanged: (value) {
                        SettingsCubit.get(context).changeAutoTheme(value);
                      },
                    );
                  },
                ),
              ],
            ),
            BlocSelector<SettingsCubit, SettingsState, bool>(
              selector: (state) {
                return state.isAutoTheme;
              },
              builder: (context, isAutoTheme) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  reverseDuration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    return SizeTransition(
                      sizeFactor: animation,
                      child: child,
                    );
                  },
                  child: (!isAutoTheme)
                      ? SizedBox(
                          height: 80,
                          child: ListView.separated(
                            padding: EdgeInsets.symmetric(
                                vertical: 20.h, horizontal: 20.w),
                            shrinkWrap: true,
                            separatorBuilder: (context, index) => SizedBox(
                              width: 20.w,
                            ),
                            itemCount: colors.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) =>
                                BlocSelector<SettingsCubit, SettingsState, int>(
                              selector: (state) {
                                return state.index ?? 0;
                              },
                              builder: (context, state) {
                                return InkWell(
                                    onTap: () => SettingsCubit.get(context)
                                        .changePrimaryColor(index),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          width: 50.w,
                                          height: 50.h,
                                          color: colors[index],
                                        ),
                                        state == index
                                            ? const Icon(
                                                Icons.done,
                                                color: Colors.white,
                                              )
                                            : const SizedBox()
                                      ],
                                    ));
                              },
                            ),
                          ),
                        )
                      : null,
                );
              },
            ),
            SizedBox(
              height: 10.h,
            ),
            Divider(
              color: Theme.of(context).colorScheme.primary,
              endIndent: 20.w,
              indent: 20.w,
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0.w),
              child: Text(
                language,
                style: optionsTitleStyle,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Center(
              child: DropdownMenu(
                  inputDecorationTheme: InputDecorationTheme(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary),
                          borderRadius: BorderRadius.circular(20.r)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary),
                          borderRadius: BorderRadius.circular(20.r)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary),
                          borderRadius: BorderRadius.circular(20.r))),
                  initialSelection: "en",
                  menuStyle: MenuStyle(
                      surfaceTintColor: WidgetStatePropertyAll(
                          Theme.of(context).colorScheme.primary)),
                  width: MediaQuery.sizeOf(context).width * .9,
                  dropdownMenuEntries: const [
                    DropdownMenuEntry(value: "en", label: 'English'),
                    DropdownMenuEntry(value: "ar", label: 'Arabic'),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
