//A tela de notificações tem que ser stateful (porque ao receber alguma notificação haverá uma mudança na tela)
//As notificações precisam de um ícone, título, tempo, texto, link
//Por agora irei realizar a tela sem alteração da API (stateless)
import 'package:flutter/material.dart';
import 'package:sisgha/app/core/utils/icones.dart';
import 'package:sisgha/app/core/utils/colors.dart';
import 'package:sisgha/app/core/utils/estilos.dart';
import 'package:sisgha/app/views/notificacao/appbar_notificacao_alunos.dart';
import 'package:sizer/sizer.dart';

class NotificacoesAlunos extends StatelessWidget {
  NotificacoesAlunos({super.key});
  final appBarAlunos = AppbarNotificacaoAlunos(
    height: 6.h,
  );

//List com as informações prensentes na notificação
//(List provisória só para fazer/entender a parte visual da tela, depois ela vai ser retirada para se dar a entrada dos dados da API)

// alias é provavelmente dessa maneira que os dados vao vir da api e tambem é mais ou menos dessa forma que serão tratados no app, parabens

  final List notificacoes = [
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
      appBar: appBarAlunos,
      body: ListView.builder(
        itemCount: notificacoes.length,
        itemBuilder: (ctx, index) => Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        notificacoes[index].icone,
                        color: CoresClaras.verdePrincipal,
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Text(
                        notificacoes[index].titulo,
                        style: estiloTexto(15,
                            cor: CoresClaras.verdePrincipalTexto,
                            peso: FontWeight.bold),
                      ),
                      Spacer(),
                      Text(
                        notificacoes[index].tempo,
                        style: TextStyle(color: CoresClaras.cinzatexto),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Text(
                    notificacoes[index].texto,
                    style: estiloTexto(15, cor: CoresClaras.pretoTexto),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: Text(
                      notificacoes[index].link,
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
