import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/app/providers/escolha_horarios_alunos.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/utils/colors.dart';
import '../../../../../core/utils/estilos.dart';
import '../../../../../core/utils/icones.dart';
import '../../../../../core/utils/padroes.dart';

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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EscolhaHorariosAlunos>(context);
    bool formacaoSelecionada =
        provider.idFormacaoSelecionada != null ? true : false;

    return GestureDetector(
      onTap: () {
        setState(() {
          espandido = !espandido;
        });
      },
      child: AnimatedContainer(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        duration: Duration(milliseconds: 300),
        decoration: _boxDecoration(formacaoSelecionada),
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
                        peso: FontWeight.bold,
                        cor: formacaoSelecionada
                            ? CoresClaras.pretoTexto
                            : CoresClaras.cinzatexto),
                  ),
                  Transform.rotate(
                    angle: espandido ? 3.14 : 0,
                    child: Iconify(
                      Icones.setaBaixo,
                      color: formacaoSelecionada
                          ? CoresClaras.verdePrincipal
                          : CoresClaras.cinzaBordas,
                      size: 36,
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
    final selecionado = provider.nomeFormacaoSelecionada == opcao;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ChoiceChip(
        chipAnimationStyle:
            ChipAnimationStyle(enableAnimation: AnimationStyle.noAnimation),
        label: Text(opcao,
            style: estiloTexto(
              14,
              cor: selecionado
                  ? CoresClaras.verdePrincipalTexto
                  : CoresClaras.cinzatexto,
            )),
        labelPadding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 0.5.h),
        showCheckmark: false,
        selected: selecionado,
        onSelected: (_) => selecionado
            ? provider.selecionarFormacao(null)
            : provider.selecionarFormacao(opcao),
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
                  : CoresClaras.cinzaBordas),
        ),
      ),
    );
  }
}

BoxDecoration _boxDecoration(bool selecionado) {
  return BoxDecoration(
      border: Border.all(
          color: selecionado
              ? CoresClaras.verdePrincipalBorda
              : CoresClaras.cinzaBordas,
          width: 2),
      borderRadius: BorderRadius.circular(15));
}
