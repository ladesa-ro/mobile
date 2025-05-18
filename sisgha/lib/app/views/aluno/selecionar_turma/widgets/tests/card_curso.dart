import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

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
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EscolhaHorariosAlunos>(context);

    bool expandido = provider.cursoExpandido;

    bool cursoSelecionado = provider.cursoSelecionado != null ? true : false;

    return GestureDetector(
      onTap: () => setState(() {
        provider.idFormacaoSelecionada != null
            ? provider.expandirCurso(!provider.cursoExpandido)
            : provider.expandirCurso(false);
      }),
      child: AnimatedContainer(
        padding: EdgeInsets.symmetric(horizontal: 15),
        duration: Duration(milliseconds: 300),
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
                    style: estiloTexto(15,
                        peso: FontWeight.bold,
                        cor: cursoSelecionado
                            ? CoresClaras.pretoTexto
                            : CoresClaras.cinzatexto),
                  ),
                  Transform.rotate(
                    angle: expandido ? 3.14 : 0,
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
              crossFadeState: expandido
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              firstChild: SizedBox.shrink(), // Quando fechado
              secondChild: SizedBox(
                height: Padroes.alturaGeral() * 0.07,
                child: ListView.builder(
                  physics: Padroes.efeitoDeRolagem(),
                  scrollDirection: Axis.horizontal,
                  itemCount: provider.listaCursos.length,
                  itemBuilder: (context, index) => quadradoSelecionavel(
                    provider.listaCursos[index].nome,
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ChoiceChip(
        chipAnimationStyle: ChipAnimationStyle(
          enableAnimation: AnimationStyle.noAnimation,
        ),
        label: Text(
          opcao,
          style: estiloTexto(
            14,
            cor: selecionado
                ? CoresClaras.verdePrincipalTexto
                : CoresClaras.cinzatexto,
          ),
        ),
        labelPadding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 0.5.h),
        showCheckmark: false,
        selected: selecionado,
        onSelected: (_) => selecionado
            ? provider.selecionarCurso(null)
            : provider.selecionarCurso(opcao),
        selectedColor: CoresClaras.verdeTransparente,
        backgroundColor: Colors.white,
        labelStyle: TextStyle(
          color: selecionado ? Colors.white : Colors.black,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: selecionado
                ? CoresClaras.verdePrincipalBorda
                : CoresClaras.cinzaBordas,
          ),
        ),
      ),
    );
  }
}
