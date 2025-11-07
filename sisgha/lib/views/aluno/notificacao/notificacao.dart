import 'package:flutter/material.dart';

import '../../../core/utils/estilos.dart';
import '../../../core/utils/icones.dart';
import '../../appbar_e_menu/app_bar/appbar_notificacao.dart';

class Notificacao extends StatefulWidget {
  final bool voltarProfessores;

  const Notificacao({
    super.key,
    required this.voltarProfessores,
  });

  @override
  State<Notificacao> createState() => _NotificacaoState();
}

class _NotificacaoState extends State<Notificacao> {
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
    final tema = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: appBarNotificacao(context, widget.voltarProfessores),
      body: ListView.builder(
        itemCount: notificacoes.length,
        itemBuilder: (ctx, index) {
          final item = notificacoes[index];
          return Column(
            children: [
              const SizedBox(height: 5),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          item.icone,
                          color: tema.secondaryFixed,
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          item.titulo,
                          style: estiloTexto(
                            15,
                            cor: tema.secondaryFixed,
                            peso: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          item.tempo,
                          style: estiloTexto(13,
                              cor: tema.tertiary, peso: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text(
                      item.texto,
                      style: estiloTexto(15, cor: tema.primary),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: Text(
                        item.link,
                        style: TextStyle(
                          color: tema.secondary,
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
                color: tema.tertiary,
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
