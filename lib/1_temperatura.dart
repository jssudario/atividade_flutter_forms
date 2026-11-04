// Questão 1 - Conversor de temperatura (Celsius -> Fahrenheit e Kelvin)

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TemperaturaPage extends StatefulWidget {
  const TemperaturaPage({super.key});

  @override
  State<TemperaturaPage> createState() => _TemperaturaPageState();
}

class _TemperaturaPageState extends State<TemperaturaPage> {
  // ---------- Estado ----------
  final _celsius = TextEditingController();

  String? _resultado;
  bool _erro = false;

  @override
  void dispose() {
    _celsius.dispose();
    super.dispose();
  }

  // ---------- Ações ----------

  // 1 casa decimal com vírgula
  String _formatar(double v) {
    final ajustado = v + (v >= 0 ? 1e-9 : -1e-9);
    final texto = ajustado.toStringAsFixed(1).replaceAll('.', ',');
    return texto == '-0,0' ? '0,0' : texto;
  }

  void _converter() {
    FocusScope.of(context).unfocus(); // fecha o teclado
    final c = double.tryParse(_celsius.text.trim().replaceAll(',', '.'));

    setState(() {
      _erro = c == null;
      _resultado = c == null
          ? 'Digite uma temperatura válida!'
          : '${_formatar(c)} °C = ${_formatar(c * 1.8 + 32)} °F = '
              '${_formatar(c + 273.15)} K';
    });
  }

  void _limpar() {
    _celsius.clear();
    setState(() {
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
        title: const Text('Conversor de temperatura'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.thermostat_rounded, size: 72, color: Colors.orange),
            const SizedBox(height: 16),
            TextField(
              controller: _celsius,
              decoration: InputDecoration(
                labelText: 'Celsius (°C)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9,.\-]')),
              ],
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _converter(),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _converter,
              child: const Text('Converter'),
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
