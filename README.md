# Formulários em Flutter

O app abre em um menu inicial com um botão para cada questão.

## Questões

| Questão | Tela | Arquivo |
|---|---|---|
| 1 | Conversor de temperatura | `lib/1_temperatura.dart` |
| 2 | Divisão da conta | `lib/2_conta.dart` |
| 3 | Inscrição em evento | `lib/3_inscricao.dart` |
| 4 | Controle de estoque | `lib/4_estoque.dart` |

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
├── 1_temperatura.dart
├── 2_conta.dart
├── 3_inscricao.dart
└── 4_estoque.dart
```
