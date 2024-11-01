import 'package:flutter/material.dart';
import 'package:news/layout/homeLayout.dart';
import 'package:news/providers/my_provider.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/shard/style/colors.dart';

class Settings extends StatelessWidget {
  static const String routName = "settings";
  Function toCategoryScreen;

  Settings(this.toCategoryScreen, {super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
          child: Row(
            children: [
              Text(
                AppLocalizations.of(context)!.arabic,
              ),
            ],
          ),
          value: "ar"),
      DropdownMenuItem(
          child: Row(
            children: [Text(AppLocalizations.of(context)!.english)],
          ),
          value: "en"),
    ];
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background.png"))),
      child: Scaffold(
        drawer: Drawer(
          backgroundColor: Colors.white,
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 80),
                  color: green,
                  child: const Text(
                    "News App",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            HomeLayout.routName,
                            (route) => false,
                          );
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.menu,
                              size: 22,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              AppLocalizations.of(context)!.category,
                              style: TextStyle(fontSize: 22),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.settings,
                              color: green,
                              size: 22,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              AppLocalizations.of(context)!.settings,
                              style: TextStyle(fontSize: 22, color: green),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.settings,
              style: TextStyle(fontSize: 22)),
          centerTitle: true,
          backgroundColor: green,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(18),
                  bottomLeft: Radius.circular(18))),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(AppLocalizations.of(context)!.language,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 20,
              ),
              // Container(
              //     padding:
              //         const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(20),
              //         border: Border.all(color: green, width: 2)),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           "English",
              //           style: TextStyle(fontSize: 22),
              //         ),
              //         IconButton(
              //             onPressed: () {
              //               showModalBottomSheet(
              //                 context: context,
              //                 builder: (context) {
              //                   // return LanguageBottomSheet();
              //                 },
              //                 shape: RoundedRectangleBorder(
              //                     borderRadius: BorderRadius.circular(18)),
              //               );
              //             },
              //             icon: Icon(Icons.keyboard_arrow_down))
              //       ],
              //     ))
              DropdownButtonFormField(
                value: provider.local,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(color: green, width: 2)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(color: green, width: 2)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(color: green, width: 2)),
                ),
                items: menuItems,
                onChanged: (value) {
                  provider.changeLocal(value ?? "en");
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
