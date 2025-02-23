import 'package:flutter/material.dart';

class TemaData {
  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.deepOrange,
    scaffoldBackgroundColor: Colors.grey[100],
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.deepOrange,
      foregroundColor: Colors.white,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.deepOrange,
      unselectedItemColor: Colors.grey,
    ),
    fontFamily: 'Outfit',
    colorScheme: const ColorScheme.light(
      primary: Colors.deepOrange,
      secondary: Colors.orange,
      surface: Colors.white,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black87),
      bodyMedium: TextStyle(color: Colors.black87),
      titleLarge: TextStyle(color: Colors.black87),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.deepOrange),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.deepOrange),
      ),
      hintStyle: TextStyle(color: Colors.grey),
    ),
    timePickerTheme: TimePickerThemeData(
      dialTextColor: Colors.black,
      dialBackgroundColor: Colors.grey[200],
      dayPeriodColor: Colors.deepOrange,
      hourMinuteTextColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: Colors.white,
      dayStyle: const TextStyle(color: Colors.black),
      headerHelpStyle: const TextStyle(color: Colors.deepOrange),
      weekdayStyle: const TextStyle(color: Colors.deepOrange),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    colorScheme: const ColorScheme.dark(primary: Colors.deepOrange),
    scaffoldBackgroundColor: const Color.fromARGB(255, 18, 18, 18),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 22, 22, 22),
      foregroundColor: Colors.deepOrange,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color.fromARGB(255, 22, 22, 22),
      selectedItemColor: Colors.deepOrange,
      unselectedItemColor: Color.fromARGB(255, 53, 53, 53),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      titleLarge: TextStyle(color: Colors.white),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.deepOrange),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.deepOrange),
      ),
      hintStyle: TextStyle(color: Colors.grey),
    ),
    timePickerTheme: TimePickerThemeData(
      dialTextColor: Colors.white,
      dialHandColor: const Color.fromARGB(255, 70, 70, 70),
      dialBackgroundColor: Colors.grey[850],
      dayPeriodColor: Colors.deepOrange,
      hourMinuteTextColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: Colors.grey[850],
      dayStyle: const TextStyle(color: Colors.deepOrange),
      headerHelpStyle: const TextStyle(color: Colors.deepOrange),
      weekdayStyle: const TextStyle(color: Colors.deepOrange),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
  );
}
