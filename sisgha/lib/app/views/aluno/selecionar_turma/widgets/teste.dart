import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/app/core/utils/colors.dart';
import 'package:sisgha/app/core/utils/estilos.dart';
import 'package:sisgha/app/core/utils/icones.dart';
import 'package:sisgha/app/core/utils/padroes.dart';
import 'package:sisgha/app/providers/escolha_horarios_alunos.dart';

class Teste extends StatefulWidget {
  const Teste({super.key});

  @override
  State<Teste> createState() => _TesteState();
}

class _TesteState extends State<Teste> {
  bool formacao = true;
  bool curso = false;
  bool turma = false;
  double alturaAtivado = Padroes.alturaGeral() * 0.15;

  @override
  Widget build(BuildContext context) {
    return Consumer<EscolhaHorariosAlunos>(
      builder: (context, provider, child) => Column(
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
              AnimatedContainer(
                padding: EdgeInsets.symmetric(horizontal: 15),
                duration: Duration(milliseconds: 500),
                decoration: BoxDecoration(
                    border:
                        Border.all(color: CoresClaras.cinzaBordas, width: 2),
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
                            'Formação',
                            style: estiloTexto(15),
                          ),
                          Transform.rotate(
                            angle: formacao ? 3.14 : 0,
                            child: Iconify(
                              Icones.setaBaixo,
                              color: CoresClaras.cinzaBordas,
                              size: 36,
                            ),
                          ),
                        ],
                      ),
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      child: formacao
                          ? SizedBox(
                              height:
                                  formacao ? Padroes.alturaGeral() * 0.07 : 0,
                              child: ListView.builder(
                                physics: Padroes.efeitoDeRolagem(),
                                scrollDirection: Axis.horizontal,
                                itemCount: provider.listaNivelFormacao.length,
                                itemBuilder: (context, index) => Container(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  margin: EdgeInsets.only(bottom: 15),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: CoresClaras.cinzaBordas),
                                  ),
                                  child: Text(provider.listaNivelFormacao[index]
                                      .ofertaFormacao['nome']!),
                                ),
                              ),
                            )
                          : null,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
