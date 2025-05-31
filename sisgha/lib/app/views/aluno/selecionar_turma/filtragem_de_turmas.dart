import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/app/core/utils/colors.dart';
import 'package:sisgha/app/core/utils/estilos.dart';
import 'package:sisgha/app/core/utils/icones.dart';
import 'package:sisgha/app/core/utils/padroes.dart';
import 'package:sisgha/app/providers/escolha_horarios_alunos.dart';
import 'package:sizer/sizer.dart';

import 'widgets/app_bar_aluno.dart';
import 'widgets/card_curso.dart';
import 'widgets/card_formacao.dart';
import 'widgets/card_turma.dart';

class FiltrargemDeTurmas extends StatefulWidget {
  const FiltrargemDeTurmas({super.key});

  @override
  State<FiltrargemDeTurmas> createState() => _TesteState();
}

class _TesteState extends State<FiltrargemDeTurmas> {
  @override
  Widget build(BuildContext context) {
    final tamanho = Padroes.alturaGeral();
    return Scaffold(
      appBar: AppbarAluno(),
      body: Column(
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
                    style: estiloTexto(18, peso: FontWeight.bold),
                  ),
                  SizedBox(width: Padroes.larguraGeral() * 0.015),
                  Icon(Icones.relogio, size: 3.h)
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
                    style: buttonStyle(botaoAtivo),
                    onPressed: () => botaoAtivo
                        ? Navigator.of(context).pushNamedAndRemoveUntil(
                            '/navegação', (route) => false)
                        : null,
                    child: Text(
                      'Ver Horário',
                      style: estiloTexto(16,
                          cor: CoresClaras.brancoTexto, peso: FontWeight.bold),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  ButtonStyle buttonStyle(bool botaoAtivo) {
    return ButtonStyle(
      minimumSize: WidgetStatePropertyAll(
          Size(double.infinity, Padroes.aluturaBotoes())),
      maximumSize: WidgetStatePropertyAll(
          Size(double.infinity, Padroes.aluturaBotoes())),
      backgroundColor: WidgetStatePropertyAll(botaoAtivo
          ? CoresClaras.verdePrincipalBotao
          : CoresClaras.cinzaBordas),
      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.circular(15)),
          ),
    );
  }
}
