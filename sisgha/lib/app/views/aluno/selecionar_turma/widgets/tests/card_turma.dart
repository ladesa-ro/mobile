import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/colors.dart';
import '../../../../../core/utils/estilos.dart';
import '../../../../../core/utils/icones.dart';
import '../../../../../core/utils/padroes.dart';
import '../../../../../providers/escolha_horarios_alunos.dart';

class CardTurma extends StatefulWidget {
  const CardTurma({super.key});

  @override
  State<CardTurma> createState() => _CardTurmaState();
}

class _CardTurmaState extends State<CardTurma> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EscolhaHorariosAlunos>(context);

    bool turmaAtiva = provider.cursoSelecionado != null ? true : false;
    return GestureDetector(
      child: AnimatedContainer(
        padding: EdgeInsets.symmetric(horizontal: 15),
        duration: Duration(milliseconds: 500),
        decoration: BoxDecoration(
            border: Border.all(color: CoresClaras.cinzaBordas, width: 2),
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: Padroes.aluturaBotoes(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Turma',
                    style: estiloTexto(15),
                  ),
                  Transform.rotate(
                    angle: turmaAtiva ? 3.14 : 0,
                    child: Iconify(
                      Icones.setaBaixo,
                      color: CoresClaras.cinzaBordas,
                      size: 36,
                    ),
                  ),
                ],
              ),
            ),
            AnimatedCrossFade(
              duration: Duration(milliseconds: 300),
              crossFadeState: turmaAtiva
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              firstChild: SizedBox.shrink(), // Quando fechado
              secondChild: SizedBox(
                height: Padroes.alturaGeral() * 0.07,
                child: ListView.builder(
                  physics: Padroes.efeitoDeRolagem(),
                  scrollDirection: Axis.horizontal,
                  itemCount: provider.listaNivelFormacao.length,
                  itemBuilder: (context, index) => quadradoSelecionavel(
                    provider.listaNivelFormacao[index].ofertaFormacao['nome']!,
                    provider,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget quadradoSelecionavel(String opcao, EscolhaHorariosAlunos provider) {
    final selecionado = provider.turmaSelecionada == opcao;

    return ChoiceChip(
      label: Text(opcao),
      showCheckmark: false,
      selected: selecionado,
      onSelected: (_) => provider.selecionarTurma(opcao),
      selectedColor: CoresClaras.verdecinza,
      backgroundColor: Colors.white,
      labelStyle: TextStyle(
        color: selecionado ? Colors.white : Colors.black,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
            color: selecionado
                ? CoresClaras.verdePrincipalBorda
                : CoresClaras.cinzaBordas),
      ),
    );
  }
}
