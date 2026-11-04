// App de exemplo: Cadastro simples (sem validação)
// TextField + TextEditingController + setState, resultado na própria tela.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const CadastroApp());

class CadastroApp extends StatelessWidget {
  const CadastroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo),
      home: const CadastroPage(),
    );
  }
}

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  // ---------- Estado ----------
  final _nome = TextEditingController();
  final _email = TextEditingController();
  final _telefone = TextEditingController();

  static const _cursos = ['Sistemas', 'Computação', 'Engenharia de Software'];
  String _curso = _cursos.first;
  bool _novidades = true;

  String? _resultado; // null = nada na tela

  @override
  void dispose() {
    _nome.dispose();
    _email.dispose();
    _telefone.dispose();
    super.dispose();
  }

  // ---------- Ações ----------
  void _cadastrar() {
    FocusScope.of(context).unfocus(); // fecha o teclado
    setState(() {
      _resultado = 'Nome: ${_nome.text.trim()}\n'
          'E-mail: ${_email.text.trim()}\n'
          'Telefone: ${_telefone.text}\n'
          'Curso: $_curso\n'
          'Novidades: ${_novidades ? 'Sim' : 'Não'}';
    });
  }

  void _limpar() {
    _nome.clear();
    _email.clear();
    _telefone.clear();
    setState(() {
      _curso = _cursos.first;
      _novidades = true;
      _resultado = null;
    });
  }

  // ---------- Tela ----------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nome,
              decoration: const InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _email,
              decoration: const InputDecoration(
                labelText: 'E-mail',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _telefone,
              decoration: const InputDecoration(
                labelText: 'Telefone',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: 16),

            // Lista de opções
            DropdownButton<String>(
              value: _curso,
              isExpanded: true,
              items: [
                for (final c in _cursos)
                  DropdownMenuItem(value: c, child: Text(c)),
              ],
              onChanged: (v) => setState(() => _curso = v!),
            ),

            // Liga/desliga
            SwitchListTile(
              title: const Text('Receber novidades'),
              value: _novidades,
              onChanged: (v) => setState(() => _novidades = v),
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 16),

            FilledButton(
              onPressed: _cadastrar,
              child: const Text('Cadastrar'),
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
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
