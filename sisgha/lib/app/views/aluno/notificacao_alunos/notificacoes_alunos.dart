//A tela de notificações tem que ser stateful (porque ao receber alguma notificação haverá uma mudança na tela)
//
import 'package:flutter/material.dart';

class NotificacoesAlunos extends StatefulWidget {
  const NotificacoesAlunos({super.key});

  @override
  State<NotificacoesAlunos> createState() => _NotificacoesAlunosState();
}

class _NotificacoesAlunosState extends State<NotificacoesAlunos> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}