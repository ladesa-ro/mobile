//A tela de notificações tem que ser stateful (porque ao receber alguma notificação haverá uma mudança na tela)
//As notificações precisam de um ícone, título, tempo, texto, link
//Por agora irei realizar a tela sem alteração com influência da API

import 'package:flutter/material.dart';
import 'package:sisgha/app/core/utils/Icones.dart';
import 'package:sisgha/app/core/utils/colors.dart';
import 'package:sisgha/app/core/utils/estilos.dart';
import 'package:sisgha/app/views/aluno/notificacao_alunos/appbar_notificacao_alunos.dart';
import 'package:sizer/sizer.dart';

class NotificacoesAlunos extends StatelessWidget {
  NotificacoesAlunos({super.key});
  final appBarAlunos = AppbarNotificacaoAlunos(
    height: 6.h,
  );

//List com as informações prensentes na notificação
//(List provisória só para fazer/entender a parte visual da tela, depois ela vai ser retirada para se dar a entrada dos dados da API)

  final List notificacoes = [
    ItensNotificacoes(
        icone: Icones.CalendarVazio,
        titulo: "Novo evento!",
        tempo: "2 dias",
        texto: "O evento IFRO Party foi agendado para o dia 10 de setembro",
        link: "Clique aqui e confira"),
    ItensNotificacoes(
        icone: Icones.IconeSisgha,
        titulo: "Novo horário",
        tempo: "5 dias",
        texto: "A aula das 13h de Filosofia II foi cancelada, aula vaga",
        link: "Clique aqui e confira"),
    ItensNotificacoes(
        icone: Icones.IconeSisgha,
        titulo: "Novo evento",
        tempo: "15 dias",
        texto:
            "A aula de Filosofia II foi trocada pela aula de Banco de Dados I",
        link: "Clique aqui e confira"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarAlunos,
      body: ListView.builder(
        itemCount: notificacoes.length,
        itemBuilder: (ctx, index) => Card(
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  notificacoes[index].icone,
                  color: ColorsTemaClaro.verdePrincipal,
                  size: 23,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notificacoes[index].titulo,
                        style: estiloTexto(15,
                            cor: ColorsTemaClaro.verdePrincipalTexto,
                            peso: FontWeight.bold),
                      ),
                      Text(
                        notificacoes[index].texto,
                        style: estiloTexto(
                          15,
                          cor: ColorsTemaClaro.pretoTexto,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(notificacoes[index].link),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  notificacoes[index].tempo,
                  style: TextStyle(
                    color: ColorsTemaClaro.cinzatexto,
                  ),
                ),
              ],
            ),
          ),
        ),
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
