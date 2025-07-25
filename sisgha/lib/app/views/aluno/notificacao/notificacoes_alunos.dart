import 'package:flutter/material.dart';
import 'package:sisgha/app/core/utils/icones.dart';
import 'package:sisgha/app/core/utils/colors.dart';
import 'package:sisgha/app/core/utils/estilos.dart';
import 'package:sisgha/app/views/notificacao/appbar_notificacao_alunos.dart';
import 'package:sizer/sizer.dart';

class NotificacoesAlunos extends StatefulWidget {
  final VoidCallback? onVoltar;

  const NotificacoesAlunos({super.key, this.onVoltar});

  @override
  State<NotificacoesAlunos> createState() => _NotificacoesAlunosState();
}

class _NotificacoesAlunosState extends State<NotificacoesAlunos> {
  // Lista de notificações provisórias
  List<ItensNotificacoes> notificacoes = [
    ItensNotificacoes(
      icone: Icones.calendario,
      titulo: "Novo evento!",
      tempo: "2 dias",
      texto: "O evento IFRO Party foi agendado para o dia 10 de setembro",
      link: "Clique aqui e confira",
    ),
    ItensNotificacoes(
      icone: Icones.iconeSisgha,
      titulo: "Novo horário",
      tempo: "5 dias",
      texto: "A aula das 13h de Filosofia II foi cancelada, aula vaga",
      link: "Clique aqui e confira",
    ),
    ItensNotificacoes(
      icone: Icones.iconeSisgha,
      titulo: "Alteração no horário",
      tempo: "15 dias",
      texto: "A aula de Filosofia II foi trocada pela aula de Banco de Dados I",
      link: "Clique aqui e confira",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarNotificacaoAlunos(
        height: 6.h,
        onVoltar: widget.onVoltar ?? () => Navigator.of(context).pop(),
      ),
      body: ListView.builder(
        itemCount: notificacoes.length,
        itemBuilder: (ctx, index) {
          final item = notificacoes[index];
          return Column(
            children: [
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          item.icone,
                          color: CoresClaras.verdePrincipal,
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          item.titulo,
                          style: estiloTexto(
                            15,
                            cor: CoresClaras.verdePrincipalTexto,
                            peso: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          item.tempo,
                          style: TextStyle(color: CoresClaras.cinzatexto),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text(
                      item.texto,
                      style: estiloTexto(15, cor: CoresClaras.pretoTexto),
                    ),
                    TextButton(
                      onPressed: () {
                       
                      },
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: Text(
                        item.link,
                        style: TextStyle(
                          color: CoresClaras.verdePrincipal,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1.5,
                color: CoresClaras.verdecinzaBorda,
              ),
            ],
          );
        },
      ),
    );
  }
}

class ItensNotificacoes {
  final IconData icone;
  final String titulo;
  final String tempo;
  final String texto;
  final String link;

  ItensNotificacoes({
    required this.icone,
    required this.titulo,
    required this.tempo,
    required this.texto,
    required this.link,
  });
}
