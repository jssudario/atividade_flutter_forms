import 'package:flutter/material.dart';

import 'menu.dart';

void main() => runApp(const AtividadeApp());

class AtividadeApp extends StatelessWidget {
  const AtividadeApp({super.key});

  @override
  Widget build(BuildContext context) {
    const rosa = Color(0xFFFFE9F0);
    const roxo = Color(0xFF6C63FF);

    return MaterialApp(
      title: 'Atividade Formulários',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: roxo,
        scaffoldBackgroundColor: rosa,
        appBarTheme: const AppBarTheme(
          backgroundColor: rosa,
          foregroundColor: roxo,
          centerTitle: true,
        ),
      ),
      home: const MenuPage(),
    );
  }
}
