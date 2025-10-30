import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../core/utils/estilos.dart';
import '../../../core/utils/icones.dart';
import '../../../core/utils/padroes.dart';
import '../../../viewmodels/escolha_horarios_alunos.dart';
import '../../appbar_e_menu/app_bar/app_bar_da_filtragem_de_turmas.dart';
import 'widgets/card_curso.dart';
import 'widgets/card_formacao.dart';
import 'widgets/card_turma.dart';

class FiltrargemDeTurmas extends StatefulWidget {
  const FiltrargemDeTurmas({super.key});

  @override
  State<FiltrargemDeTurmas> createState() => _FiltrargemDeTurmas();
}

class _FiltrargemDeTurmas extends State<FiltrargemDeTurmas> {
  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).colorScheme;
    final tamanho = Padroes.alturaGeral();
    return Scaffold(
      appBar: appBarFiltragemTurmas(context),
      body: ListView(
        physics: Padroes.efeitoDeRolagem(),
        padding: Padroes.margem().copyWith(top: tamanho * 0.15),
        children: [
          Row(
            children: [
              Icon(Icones.relogio,
                  color: tema.onPrimaryFixedVariant, size: 3.h),
              SizedBox(width: Padroes.larguraGeral() * 0.015),
              Text(
                'Selecionar Horario',
                style:
                    estiloTexto(18, cor: tema.primary, peso: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: tamanho * 0.02),
          CardFormacao(),
          SizedBox(height: tamanho * 0.02),
          CardCurso(),
          SizedBox(height: tamanho * 0.02),
          CardTurma(),
          SizedBox(height: tamanho * 0.02),
          Consumer<EscolhaHorariosAlunos>(
            builder: (context, provider, child) {
              final botaoAtivo = provider.idFormacaoSelecionada != null &&
                  provider.cursoSelecionado != null &&
                  provider.turmaSelecionada != null;

              return ElevatedButton(
                style: buttonStyle(botaoAtivo, tema),
                onPressed: () => botaoAtivo
                    ? Navigator.of(context)
                        .pushNamedAndRemoveUntil('/navegação', (_) => false)
                    : null,
                child: Text(
                  'Ver Horário',
                  style: estiloTexto(16,
                      cor: tema.inversePrimary, peso: FontWeight.bold),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  ButtonStyle buttonStyle(bool botaoAtivo, ColorScheme tema) {
    return ButtonStyle(
      minimumSize: WidgetStatePropertyAll(
        Size(double.infinity, Padroes.aluturaBotoes()),
      ),
      maximumSize: WidgetStatePropertyAll(
        Size(double.infinity, Padroes.aluturaBotoes()),
      ),
      backgroundColor: WidgetStatePropertyAll(
        botaoAtivo ? tema.primaryContainer : tema.tertiaryContainer,
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
