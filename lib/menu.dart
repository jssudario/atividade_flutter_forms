// Menu inicial para selecionar a questão a ser testada

import 'package:flutter/material.dart';

import 'q1_temperatura.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  void _abrir(BuildContext context, Widget tela) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => tela));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Atividade Formulários')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.thermostat_rounded),
              title: const Text('Q1 - Conversor de temperatura'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _abrir(context, const TemperaturaPage()),
            ),
          ),
        ],
      ),
    );
  }
}
