import 'package:flutter/material.dart';

class ErroConnectLogin extends StatefulWidget {
  const ErroConnectLogin({super.key});

  @override
  State<ErroConnectLogin> createState() => _ErroConnectState();
}

class _ErroConnectState extends State<ErroConnectLogin> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Erro de Conexão'),
      content: const Text(
          'O tempo limite da sua conexão foi atingido. Por favor, entre novamente.'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, "/login", (route) => false);
          },
          child: const Text('Voltar'),
        ),
      ],
    );
  }
}
