// Questão 2 - Divisão da conta (valor + gorjeta dividido entre as pessoas)

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ContaPage extends StatefulWidget {
  const ContaPage({super.key});

  @override
  State<ContaPage> createState() => _ContaPageState();
}

class _ContaPageState extends State<ContaPage> {
  // ---------- Estado ----------
  final _valor = TextEditingController();
  final _pessoas = TextEditingController();

  static const _gorjetas = [0, 10, 15, 20];
  int _gorjeta = 10;

  String? _resultado;
  bool _erro = false;

  @override
  void dispose() {
    _valor.dispose();
    _pessoas.dispose();
    super.dispose();
  }

  // ---------- Ações ----------

  // 2 casas decimais com vírgula
  String _formatar(double v) {
    final texto = (v + 1e-9).toStringAsFixed(2).replaceAll('.', ',');
    return 'R\$ $texto';
  }

  void _calcular() {
    FocusScope.of(context).unfocus(); // fecha o teclado
    final valor = double.tryParse(_valor.text.trim().replaceAll(',', '.'));
    final pessoas = int.tryParse(_pessoas.text.trim());

    setState(() {
      if (valor == null || pessoas == null || pessoas == 0) {
        _erro = true;
        _resultado = 'Preencha o valor e o número de pessoas.';
        return;
      }
      final gorjeta = valor * _gorjeta / 100;
      final total = valor + gorjeta;
      _erro = false;
      _resultado = 'Gorjeta ${_formatar(gorjeta)} · '
          'Total ${_formatar(total)} · '
          '${_formatar(total / pessoas)} por pessoa';
    });
  }

  void _limpar() {
    _valor.clear();
    _pessoas.clear();
    setState(() {
      _gorjeta = 10;
      _erro = false;
      _resultado = null;
    });
  }

  // ---------- Tela ----------
  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Voltar',
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Divisão da conta'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.restaurant_rounded, size: 72, color: Colors.orange),
            const SizedBox(height: 16),
            TextField(
              controller: _valor,
              decoration: InputDecoration(
                labelText: 'Valor da conta (R\$)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9,.]')),
              ],
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _pessoas,
              decoration: InputDecoration(
                labelText: 'Número de pessoas',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _calcular(),
            ),
            const SizedBox(height: 16),
            const Text('Gorjeta'),
            const SizedBox(height: 8),
            SegmentedButton<int>(
              showSelectedIcon: false,
              segments: [
                for (final g in _gorjetas)
                  ButtonSegment(value: g, label: Text('$g%')),
              ],
              selected: {_gorjeta},
              onSelectionChanged: (s) => setState(() => _gorjeta = s.first),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _calcular,
              child: const Text('Calcular'),
            ),
            TextButton(
              onPressed: _limpar,
              child: const Text('Limpar'),
            ),

            // ---------- Resultado na própria tela ----------
            if (_resultado != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    _resultado!,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: _erro ? cores.error : null,
                        ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
