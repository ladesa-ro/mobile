import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/app/core/utils/colors.dart';
import 'package:sisgha/app/core/utils/estilos.dart';
import 'package:sisgha/app/core/utils/icones.dart';
import 'package:sisgha/app/core/utils/padroes.dart';
import 'package:sisgha/app/providers/escolha_horarios_alunos.dart';
import 'package:sisgha/app/views/aluno/selecionar_turma/widgets/cards_selecao.dart';

class Teste extends StatefulWidget {
  const Teste({super.key});

  @override
  State<Teste> createState() => _TesteState();
}

class _TesteState extends State<Teste> {
  double alturaAtivado = Padroes.alturaGeral() * 0.15;

  @override
  Widget build(BuildContext context) {
    return Consumer<EscolhaHorariosAlunos>(
      builder: (context, provider, child) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListView(
            shrinkWrap: true,
            physics: Padroes.efeitoDeRolagem(),
            padding: Padroes.margem(),
            children: [
              Row(
                children: [
                  Text(
                    'Selecionar Horario',
                    style: estiloTexto(15, peso: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Icon(Icones.relogio)
                ],
              ),
              SizedBox(
                height: 20,
              ),
              cardFormacao(context),
              CardCurso(context),
              CardTurma(context)
            ],
          ),
        ],
      ),
    );
  }

  Widget quadradosSelecionaveis(
    String opcoes,
  ) {
    return GestureDetector(
      onTap: () => {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        margin: EdgeInsets.only(bottom: 15, right: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: CoresClaras.cinzaBordas),
        ),
        child: Text(opcoes),
      ),
    );
  }
}
