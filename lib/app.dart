import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

class TodoCaseritoApp extends StatelessWidget {
  const TodoCaseritoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo Caserito — A Tu Mesa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFC8472B)),
        scaffoldBackgroundColor: const Color(0xFFFAF8F3),
      ),
      home: const HomeScreen(),
    );
  }
}
