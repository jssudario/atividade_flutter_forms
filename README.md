# Formulários em Flutter

O app abre em um menu inicial com um botão para cada questão.

## Questões

| Questão | Tela | Arquivo |
|---|---|---|
| 1 | Conversor de temperatura | `lib/q1_temperatura.dart` |
| 2 | Divisão da conta | `lib/q2_conta.dart` |
| 3 | Inscrição em evento | `lib/q3_inscricao.dart` |
| 4 | Controle de estoque | `lib/q4_estoque.dart` |

## Como rodar

Pré-requisito: [Flutter](https://docs.flutter.dev/get-started/install) instalado.

1. Baixe as dependências:
   ```
   flutter pub get
   ```
2. Rode o app (por exemplo, no Chrome):
   ```
   flutter run -d chrome
   ```
   Para ver os dispositivos disponíveis, use `flutter devices`.
3. No menu inicial, toque na questão que quer testar. A seta no canto da barra volta ao menu.

Não há pacotes externos: o projeto usa só o Flutter.

## Estrutura

```
lib/
├── main.dart              # tema e ponto de entrada
├── menu.dart              # menu inicial
├── q1_temperatura.dart
├── q2_conta.dart
├── q3_inscricao.dart
└── q4_estoque.dart
```
