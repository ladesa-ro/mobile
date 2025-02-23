//A tela de notificações tem que ser stateful (porque ao receber alguma notificação haverá uma mudança na tela)
//
import 'package:flutter/material.dart';
import 'package:sisgha/app/views/aluno/notificacao_alunos/appbar_notificacao_alunos.dart';
import 'package:sizer/sizer.dart';

class NotificacoesAlunos extends StatefulWidget {
  const NotificacoesAlunos({super.key});

  @override
  State<NotificacoesAlunos> createState() => _NotificacoesAlunosState();
}

class _NotificacoesAlunosState extends State<NotificacoesAlunos> {
  @override
  Widget build(BuildContext context) {
    final appBarAlunos = AppbarNotificacaoAlunos(height: 6.h,);
    return Scaffold(
      appBar: appBarAlunos,
    );
  }
}