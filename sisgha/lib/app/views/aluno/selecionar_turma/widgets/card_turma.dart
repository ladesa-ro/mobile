import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/estilos.dart';
import '../../../../core/utils/icones.dart';
import '../../../../core/utils/padroes.dart';
import '../../../../cache/escolha_horarios_alunos.dart';

class CardTurma extends StatefulWidget {
  const CardTurma({super.key});

  @override
  State<CardTurma> createState() => _CardTurmaState();
}

class _CardTurmaState extends State<CardTurma> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EscolhaHorariosAlunos>(
      builder: (context, provider, child) {
        final expandido = provider.turmaExpandida;
        final turmaSelecionada = provider.turmaSelecionada != null;

        return GestureDetector(
          onTap: () {
            if (provider.cursoSelecionado != null) {
              provider.expandirTurma(!expandido);
            } else {
              provider.expandirTurma(false);
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            decoration: bordasCardsAlunos(turmaSelecionada),
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
                        style: estiloTexto(
                          15,
                          peso: FontWeight.bold,
                          cor: turmaSelecionada
                              ? CoresClaras.pretoTexto
                              : CoresClaras.cinzatexto,
                        ),
                      ),
                      Transform.rotate(
                        angle: expandido ? 3.14 : 0,
                        child: Iconify(
                          Icones.setaBaixo,
                          color: turmaSelecionada
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
                      itemCount: provider.listaTurmas.length,
                      itemBuilder: (context, index) {
                        final nome = provider.listaTurmas[index].nome;
                        final selecionado = provider.turmaSelecionada == nome;

                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 1.w),
                          child: ChoiceChip(
                            chipAnimationStyle: ChipAnimationStyle(
                              enableAnimation: AnimationStyle.noAnimation,
                            ),
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
                                ? provider.selecionarTurma(null)
                                : provider.selecionarTurma(nome),
                            selectedColor: CoresClaras.verdeTransparente,
                            backgroundColor: Colors.white,
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
    final selecionado = provider.turmaSelecionada == opcao;

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
            ? provider.selecionarTurma(null)
            : provider.selecionarTurma(opcao),
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
