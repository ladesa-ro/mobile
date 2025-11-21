import 'package:flutter/material.dart';

import '../../../core/utils/estilos.dart';

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
  // ================================
  // SEU CÓDIGO ORIGINAL — LISTAGEM
  // ================================
  //
  // List<ItensNotificacoes> notificacoes = [
  //   ItensNotificacoes(
  //     icone: Icones.calendario,
  //     titulo: "Novo evento!",
  //     tempo: "2 dias",
  //     texto: "O evento IFRO Party foi agendado para o dia 10 de setembro",
  //     link: "Clique aqui e confira",
  //   ),
  //   ItensNotificacoes(
  //     icone: Icones.iconeSisgha,
  //     titulo: "Novo horário",
  //     tempo: "5 dias",
  //     texto: "A aula das 13h de Filosofia II foi cancelada, aula vaga",
  //     link: "Clique aqui e confira",
  //   ),
  //   ItensNotificacoes(
  //     icone: Icones.iconeSisgha,
  //     titulo: "Alteração no horário",
  //     tempo: "15 dias",
  //     texto: "A aula de Filosofia II foi trocada pela aula de Banco de Dados I",
  //     link: "Clique aqui e confira",
  //   ),
  // ];
  //
  // FIM DO CÓDIGO ORIGINAL
  // ================================

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: appBarNotificacao(context, widget.voltarProfessores),

      // ===========================
      // TELA IGUAL AO PRINT
      // ===========================
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_off_outlined,
              size: 140,
              color: Colors.grey.shade400,
            ),

            const SizedBox(height: 20),

            Text(
              "Esta tela ainda não foi\n Desenvolvida.",
              textAlign: TextAlign.center,
              style: estiloTexto(
                16,
                peso: FontWeight.bold,
                cor: tema.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================================
// SUA CLASSE ORIGINAL — MANTIDA
// ================================
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
