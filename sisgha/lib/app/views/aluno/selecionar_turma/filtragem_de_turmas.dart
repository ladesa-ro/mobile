import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/app/core/utils/colors.dart';
import 'package:sisgha/app/core/utils/estilos.dart';
import 'package:sisgha/app/core/utils/icones.dart';
import 'package:sisgha/app/core/utils/padroes.dart';
import 'package:sisgha/app/providers/escolha_horarios_alunos.dart';

import '../notificacao/widgets/card_curso.dart';
import '../notificacao/widgets/card_formacao.dart';
import '../notificacao/widgets/card_turma.dart';
import 'widgets/app_bar_aluno.dart';

class FiltrargemDeTurmas extends StatefulWidget {
  const FiltrargemDeTurmas({super.key});

  @override
  State<FiltrargemDeTurmas> createState() => _TesteState();
}

class _TesteState extends State<FiltrargemDeTurmas> {
  @override
  Widget build(BuildContext context) {
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
              CardFormacao(),
              SizedBox(height: 20),
              CardCurso(),
              SizedBox(height: 20),
              CardTurma(),
              SizedBox(height: 20),
              Consumer<EscolhaHorariosAlunos>(
                builder: (context, provider, child) {
                  final botaoAtivo = provider.idFormacaoSelecionada != null &&
                      provider.cursoSelecionado != null &&
                      provider.turmaSelecionada != null;

                  return ElevatedButton(
                    style: buttonStyle(),
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

  ButtonStyle buttonStyle() {
    return ButtonStyle(
      minimumSize: WidgetStatePropertyAll(
          Size(double.infinity, Padroes.aluturaBotoes())),
      maximumSize: WidgetStatePropertyAll(
          Size(double.infinity, Padroes.aluturaBotoes())),
      backgroundColor: WidgetStatePropertyAll(CoresClaras.verdePrincipalBotao),
      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
          side: BorderSide(color: CoresClaras.verdePrincipalBorda),
          borderRadius: BorderRadiusGeometry.circular(15))),
    );
  }
}
