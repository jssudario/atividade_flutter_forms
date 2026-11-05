// Questão 4 - Controle de estoque (cadastro de produtos em uma lista)

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class _Produto {
  final String nome;
  final double preco;
  final int quantidade;

  const _Produto({
    required this.nome,
    required this.preco,
    required this.quantidade,
  });

  double get subtotal => preco * quantidade;
}

class EstoquePage extends StatefulWidget {
  const EstoquePage({super.key});

  @override
  State<EstoquePage> createState() => _EstoquePageState();
}

class _EstoquePageState extends State<EstoquePage> {
  // ---------- Estado ----------
  final _formKey = GlobalKey<FormState>();
  final _produto = TextEditingController();
  final _preco = TextEditingController();
  final _quantidade = TextEditingController();

  final List<_Produto> _produtos = [];

  // O total é calculado da lista, então atualiza sozinho ao remover.
  double get _total => _produtos.fold(0.0, (soma, p) => soma + p.subtotal);

  @override
  void dispose() {
    _produto.dispose();
    _preco.dispose();
    _quantidade.dispose();
    super.dispose();
  }

  // ---------- Validações ----------
  double? _lerPreco(String? v) {
    return double.tryParse((v ?? '').trim().replaceAll(',', '.'));
  }

  String? _validarProduto(String? v) {
    final nome = (v ?? '').trim().toLowerCase();
    if (nome.length < 2) return 'Informe o produto';
    if (_produtos.any((p) => p.nome.toLowerCase() == nome)) {
      return 'Produto já cadastrado';
    }
    return null;
  }

  String? _validarPreco(String? v) {
    final p = _lerPreco(v);
    return p == null || p <= 0 ? 'Preço maior que zero' : null;
  }

  String? _validarQuantidade(String? v) {
    final q = int.tryParse(v ?? '');
    return q == null || q < 1 || q > 999 ? 'Quantidade entre 1 e 999' : null;
  }

  // ---------- Ações ----------

  // R$ com 2 casas, vírgula decimal e ponto de milhar (ex.: R$ 1.250,00)
  String _formatar(double v) {
    final partes = (v + 1e-9).toStringAsFixed(2).split('.');
    final inteiro = partes[0].replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (_) => '.',
    );
    return 'R\$ $inteiro,${partes[1]}';
  }

  void _adicionar() {
    FocusScope.of(context).unfocus(); // fecha o teclado
    if (!_formKey.currentState!.validate()) return;

    final novo = _Produto(
      nome: _produto.text.trim(),
      preco: _lerPreco(_preco.text)!,
      quantidade: int.parse(_quantidade.text),
    );
    _formKey.currentState!.reset();
    setState(() => _produtos.add(novo));
  }

  void _remover(int i) {
    setState(() => _produtos.removeAt(i));
  }

  void _limpar() {
    _formKey.currentState!.reset();
    setState(() => _produtos.clear());
  }

  // ---------- Tela ----------
  @override
  Widget build(BuildContext context) {
    final n = _produtos.length;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Voltar',
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Controle de estoque'),
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
                Icons.inventory_2_rounded,
                size: 72,
                color: Colors.orange,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _produto,
                decoration: InputDecoration(
                  labelText: 'Produto',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.next,
                validator: _validarProduto,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _preco,
                decoration: InputDecoration(
                  labelText: 'Preço (R\$)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9,.]')),
                ],
                textInputAction: TextInputAction.next,
                validator: _validarPreco,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _quantidade,
                decoration: InputDecoration(
                  labelText: 'Quantidade',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textInputAction: TextInputAction.done,
                validator: _validarQuantidade,
                onFieldSubmitted: (_) => _adicionar(),
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: _adicionar,
                child: const Text('Adicionar'),
              ),
              TextButton(
                onPressed: _limpar,
                child: const Text('Limpar'),
              ),

              // ---------- Resumo ----------
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    '$n ${n == 1 ? 'produto' : 'produtos'} · '
                    'Total ${_formatar(_total)}',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),

              // ---------- Lista na própria tela ----------
              if (_produtos.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Nenhum produto cadastrado.',
                    textAlign: TextAlign.center,
                  ),
                )
              else
                for (var i = 0; i < _produtos.length; i++)
                  Card(
                    child: ListTile(
                      title: Text(_produtos[i].nome),
                      subtitle: Text(
                        'Qtd ${_produtos[i].quantidade} · '
                        'Unit. ${_formatar(_produtos[i].preco)} · '
                        'Subtotal ${_formatar(_produtos[i].subtotal)}',
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline),
                        tooltip: 'Remover',
                        onPressed: () => _remover(i),
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
