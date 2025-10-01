import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/estilos.dart';
import '../../../../core/utils/icones.dart';
import '../../../../core/utils/padroes.dart';
import '../../../../viewmodels/escolha_horarios_alunos.dart';

class CardFormacao extends StatefulWidget {
  const CardFormacao({super.key});

  @override
  State<CardFormacao> createState() => _CardFormacaoState();
}

class _CardFormacaoState extends State<CardFormacao> {
  late bool espandido;

  @override
  void initState() {
    super.initState();
    espandido = true;
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () {
        setState(() {
          espandido = !espandido;
        });
      },
      child: Consumer<EscolhaHorariosAlunos>(
        builder: (context, provider, child) {
          final formacaoSelecionada = provider.idFormacaoSelecionada != null;

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            decoration: bordasCardsAlunos(formacaoSelecionada, tema),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: Padroes.aluturaBotoes(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Formação',
                        style: estiloTexto(15,
                            peso: FontWeight.bold, cor: tema.primary),
                      ),
                      Transform.rotate(
                        angle: espandido ? 3.14 : 0,
                        child: Iconify(
                          Icones.setaBaixo,
                          color: formacaoSelecionada
                              ? tema.secondaryFixed
                              : tema.tertiaryFixed,
                          size: 3.5.h,
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedCrossFade(
                  duration: Duration(milliseconds: 300),
                  crossFadeState: espandido
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  firstChild: SizedBox.shrink(),
                  secondChild: SizedBox(
                    height: Padroes.alturaGeral() * 0.07,
                    child: ListView.builder(
                      physics: Padroes.efeitoDeRolagem(),
                      scrollDirection: Axis.horizontal,
                      itemCount: provider.listaNivelFormacao.length,
                      itemBuilder: (context, index) {
                        final nome = provider
                            .listaNivelFormacao[index].ofertaFormacao['nome']!;
                        final selecionado =
                            provider.nomeFormacaoSelecionada == nome;

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
                                    ? tema.secondary
                                    : tema.tertiary,
                                peso: FontWeight.bold,
                              ),
                            ),
                            labelPadding: EdgeInsets.symmetric(
                                horizontal: 1.w, vertical: 0.5.h),
                            showCheckmark: false,
                            selected: selecionado,
                            onSelected: (_) {
                              if (!selecionado) {
                                // Seleciona a formação
                                provider.selecionarFormacao(nome);
                              } else {
                                // Opcional: desmarcar explicitamente
                                provider.selecionarFormacao(null);
                              }
                            },
                            selectedColor: tema.surfaceVariant,
                            backgroundColor: tema.surface,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.sp),
                              side: BorderSide(
                                color: selecionado
                                    ? tema.onPrimary
                                    : tema.onSecondary,
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
          );
        },
      ),
    );
  }
}
