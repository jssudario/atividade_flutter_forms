// Questão 3 - Inscrição em evento (Form + TextFormField + validator)

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InscricaoPage extends StatefulWidget {
  const InscricaoPage({super.key});

  @override
  State<InscricaoPage> createState() => _InscricaoPageState();
}

class _InscricaoPageState extends State<InscricaoPage> {
  // ---------- Estado ----------
  final _formKey = GlobalKey<FormState>();
  final _nome = TextEditingController();
  final _email = TextEditingController();
  final _idade = TextEditingController();

  static const _ingressos = {
    'Estudante': 30.0,
    'Profissional': 80.0,
    'VIP': 150.0,
  };
  String? _ingresso;

  String? _resultado; // null = nada na tela

  @override
  void dispose() {
    _nome.dispose();
    _email.dispose();
    _idade.dispose();
    super.dispose();
  }

  // ---------- Validações ----------
  String? _validarNome(String? v) {
    return (v ?? '').trim().length < 3 ? 'Informe o nome completo' : null;
  }

  String? _validarEmail(String? v) {
    final e = (v ?? '').trim();
    final arroba = e.indexOf('@');
    return arroba < 0 || !e.substring(arroba).contains('.')
        ? 'E-mail inválido'
        : null;
  }

  String? _validarIdade(String? v) {
    final i = int.tryParse(v ?? '');
    return i == null || i < 14 || i > 100 ? 'Idade entre 14 e 100' : null;
  }

  // ---------- Ações ----------
  void _inscrever() {
    FocusScope.of(context).unfocus(); // fecha o teclado

    if (!_formKey.currentState!.validate()) {
      setState(() => _resultado = null);
      return;
    }

    var preco = _ingressos[_ingresso]!;
    if (int.parse(_idade.text) <= 17) preco /= 2; // até 17 anos paga metade
    final valor = preco.toStringAsFixed(2).replaceAll('.', ',');

    setState(() {
      _resultado = 'Inscrição de ${_nome.text.trim()} '
          '(${_email.text.trim()}) · $_ingresso · R\$ $valor';
    });
  }

  void _limpar() {
    _formKey.currentState!.reset();
    setState(() {
      _ingresso = null;
      _resultado = null;
    });
  }

  // ---------- Tela ----------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Voltar',
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Inscrição em evento'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.confirmation_number_rounded,
                size: 72,
                color: Colors.orange,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nome,
                decoration: InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                validator: _validarNome,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _email,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: _validarEmail,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _idade,
                decoration: InputDecoration(
                  labelText: 'Idade',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textInputAction: TextInputAction.done,
                validator: _validarIdade,
                onFieldSubmitted: (_) => _inscrever(),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Tipo de ingresso',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                items: [
                  for (final i in _ingressos.keys)
                    DropdownMenuItem(value: i, child: Text(i)),
                ],
                onChanged: (v) => setState(() => _ingresso = v),
                validator: (v) => v == null ? 'Escolha o ingresso' : null,
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: _inscrever,
                child: const Text('Inscrever'),
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
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
