import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  scaffoldBackgroundColor: const Color.fromARGB(255, 29, 29, 29),
  dividerColor: Colors.white24,
  progressIndicatorTheme: const ProgressIndicatorThemeData(color: Colors.amber),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 20,
    ),
    iconTheme: IconThemeData(color: Colors.white),
    color: Color.fromARGB(255, 29, 29, 29),
  ),
  listTileTheme:
      const ListTileThemeData(iconColor: Color.fromARGB(255, 165, 165, 165)),
  textTheme: const TextTheme(
      bodyMedium: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),
      bodySmall: TextStyle(
        color: Color.fromARGB(255, 165, 165, 165),
        fontWeight: FontWeight.w300,
        fontSize: 16,
      )),
  useMaterial3: false,
);
