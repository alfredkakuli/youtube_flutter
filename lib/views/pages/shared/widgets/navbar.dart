import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:full_screen_app/theme/color_scheme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../state/ui/ui_provider.dart';

Widget navbar(context) => SafeArea(
    bottom: false,
    child: Consumer<UiProvider>(builder: (_, uiProvider, _2) {
      return Container(
          margin: const EdgeInsets.all(5.0),
          padding: const EdgeInsets.all(5.0),
          height: 60.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  InkWell(
                    onHover: (value) => {},
                    onTap: () => {
                      uiProvider.setSidebar(true),
                    },
                    child: Icon(
                      Icons.menu_rounded,
                      color: Theme.of(context).colorScheme.onBackground,
                      size: 24.0,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  InkWell(
                    onHover: (value) => {},
                    onTap: () => {
                      uiProvider.toggleTheme(),
                    },
                    child: Icon(
                      uiProvider.getThemeMode ? Icons.light_mode : Icons.dark_mode,
                      size: 24.0,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  InkWell(
                    onHover: (value) => {},
                    onTap: () => {},
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      size: 24.0,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Stack(
                    children: [
                      InkWell(
                        onHover: (value) => {},
                        onTap: () => {},
                        child: Icon(
                          Icons.notifications,
                          size: 24.0,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      Positioned(
                          top: 0,
                          left: 10.0,
                          child: Container(
                            height: 15.0,
                            width: 15.0,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(1.0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.error,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              "7",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0, color: Theme.of(context).colorScheme.errorContainer),
                            ),
                          ))
                    ],
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Row(
                    children: [
                      Text(uiProvider.getLogedUser != null ? uiProvider.getLogedUser['user_name'].toString() : ""),
                      smallHorinzontalSpacer(),
                      InkWell(
                        onHover: (value) => {},
                        onTap: () => {},
                        child: Expanded(
                          child: Container(
                            width: 30.0,
                            height: 30.0,
                            // height: deviceHeight * 0.025,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(255, 255, 255, 0.0),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Container(
                              decoration: BoxDecoration(color: Theme.of(context).colorScheme.error, image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(uiProvider.getLogedUser != null ? uiProvider.getLogedUser['profile_image_url'].toString() : "")), shape: BoxShape.circle),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                        ),

                        // (
                        //   child: Icon(
                        //     Icons.account_circle,
                        //     size: 24.0,
                        //     color: Theme.of(context).colorScheme.onBackground,
                        //   ),
                        // ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                ],
              )
            ],
          ));
    }));
