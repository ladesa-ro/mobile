import 'package:flutter/material.dart';

class ErroConnect extends StatefulWidget {
  const ErroConnect({super.key});

  @override
  State<ErroConnect> createState() => _ErroConnectState();
}

class _ErroConnectState extends State<ErroConnect> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Erro de Conexão'),
      content: const Text(
          'O tempo limite da requisição foi atingido. Por favor, verifique sua conexão com a internet e tente novamente.'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
