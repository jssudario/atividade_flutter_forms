// Menu inicial para selecionar a questão a ser testada

import 'package:flutter/material.dart';

import '1_temperatura.dart';
import '2_conta.dart';
import '3_inscricao.dart';
import '4_estoque.dart';

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
              title: const Text('1 - Conversor de temperatura'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _abrir(context, const TemperaturaPage()),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.restaurant_rounded),
              title: const Text('2 - Divisão da conta'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _abrir(context, const ContaPage()),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.confirmation_number_rounded),
              title: const Text('3 - Inscrição em evento'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _abrir(context, const InscricaoPage()),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.inventory_2_rounded),
              title: const Text('4 - Controle de estoque'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _abrir(context, const EstoquePage()),
            ),
          ),
        ],
      ),
    );
  }
}
