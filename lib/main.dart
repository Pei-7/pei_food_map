import 'package:flutter/material.dart';

import 'home_page.dart';

void main() {
  runApp(MaterialApp(
      theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 169, 45, 70),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
          textTheme: const TextTheme(
            headlineLarge: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 169, 45, 70)),
            bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
          ),
          useMaterial3: true),
      home: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}
