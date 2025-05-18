import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/colors.dart';
import '../../../../../core/utils/estilos.dart';
import '../../../../../core/utils/icones.dart';
import '../../../../../core/utils/padroes.dart';
import '../../../../../providers/escolha_horarios_alunos.dart';

class CardCurso extends StatefulWidget {
  const CardCurso({super.key});

  @override
  State<CardCurso> createState() => _CardCursoState();
}

class _CardCursoState extends State<CardCurso> {
  bool cursoAtivo = false;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<EscolhaHorariosAlunos>(context, listen: false);

    print(provider.idFormacaoSelecionada);
    cursoAtivo = provider.idFormacaoSelecionada != null ||
            provider.idFormacaoSelecionada != ''
        ? true
        : false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EscolhaHorariosAlunos>(context);

    return GestureDetector(
      onTap: () {
        setState(() {
          cursoAtivo = !cursoAtivo;
        });
      },
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
                    'Curso',
                    style: estiloTexto(15),
                  ),
                  Transform.rotate(
                    angle: cursoAtivo ? 3.14 : 0,
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
              crossFadeState: cursoAtivo
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
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
    final selecionado = provider.cursoSelecionado == opcao;

    return ChoiceChip(
      label: Text(opcao),
      showCheckmark: false,
      selected: selecionado,
      onSelected: (_) => provider.selecionarCurso(opcao),
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
