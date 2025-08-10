import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/estilos.dart';
import '../../../../core/utils/icones.dart';
import '../../../../core/utils/padroes.dart';
import '../../../../viewmodels/escolha_horarios_alunos.dart';

class CardCurso extends StatefulWidget {
  const CardCurso({super.key});

  @override
  State<CardCurso> createState() => _CardCursoState();
}

class _CardCursoState extends State<CardCurso> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EscolhaHorariosAlunos>(
      builder: (context, provider, child) {
        bool expandido = provider.cursoExpandido;
        bool cursoSelecionado = provider.cursoSelecionado != null;

        return GestureDetector(
          onTap: () {
            if (provider.idFormacaoSelecionada != null) {
              provider.expandirCurso(!expandido);
            } else {
              provider.expandirCurso(false);
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            decoration: bordasCardsAlunos(cursoSelecionado),
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
                        style: estiloTexto(
                          15,
                          peso: FontWeight.bold,
                          cor: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                      Transform.rotate(
                        angle: expandido ? 3.14 : 0,
                        child: Iconify(
                          Icones.setaBaixo,
                          color: cursoSelecionado
                              ? CoresClaras.verdePrincipal
                              : CoresClaras.cinzaBordas,
                          size: 3.5.h,
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
                  firstChild: SizedBox.shrink(),
                  secondChild: SizedBox(
                    height: Padroes.alturaGeral() * 0.07,
                    child: ListView.builder(
                      physics: Padroes.efeitoDeRolagem(),
                      scrollDirection: Axis.horizontal,
                      itemCount: provider.listaCursos.length,
                      itemBuilder: (context, index) {
                        final nome = provider.listaCursos[index].nome;
                        final selecionado = provider.cursoSelecionado == nome;

                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 1.w),
                          child: ChoiceChip(
                            chipAnimationStyle: ChipAnimationStyle(
                                enableAnimation: AnimationStyle.noAnimation),
                            label: Text(
                              nome,
                              style: estiloTexto(
                                15,
                                cor: selecionado
                                    ? CoresClaras.verdePrincipalTexto
                                    : CoresClaras.cinzatexto,
                                peso: FontWeight.bold,
                              ),
                            ),
                            labelPadding: EdgeInsets.symmetric(
                                horizontal: 1.w, vertical: 0.5.h),
                            showCheckmark: false,
                            selected: selecionado,
                            onSelected: (_) => selecionado
                                ? provider.selecionarCurso(null)
                                : provider.selecionarCurso(nome),
                            selectedColor: CoresClaras.verdeTransparente,
                            backgroundColor:
                                Theme.of(context).colorScheme.surfaceVariant,
                            labelStyle: TextStyle(
                              color: selecionado ? Colors.white : Colors.black,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.sp),
                              side: BorderSide(
                                color: selecionado
                                    ? CoresClaras.verdePrincipalBorda
                                    : CoresClaras.cinzaBordas,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
