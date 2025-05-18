import 'package:flutter/cupertino.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/app/providers/escolha_horarios_alunos.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/estilos.dart';
import '../../../../core/utils/icones.dart';
import '../../../../core/utils/padroes.dart';

Widget cardFormacao(BuildContext context) {
  final provider = Provider.of<EscolhaHorariosAlunos>(context);

  bool formacaoAtiva = true;
  return GestureDetector(
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
                  'Formação',
                  style: estiloTexto(15),
                ),
                Transform.rotate(
                  angle: formacaoAtiva ? 3.14 : 0,
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
            height: formacaoAtiva ? Padroes.alturaGeral() * 0.07 : 0,
            child: formacaoAtiva
                ? ListView.builder(
                    physics: Padroes.efeitoDeRolagem(),
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.listaNivelFormacao.length,
                    itemBuilder: (context, index) => quadradosSelecionaveis(
                        provider
                            .listaNivelFormacao[index].ofertaFormacao['nome']!,
                        provider))
                : null,
          ),
        ],
      ),
    ),
  );
}

Widget CardCurso(BuildContext context) {
  final provider = Provider.of<EscolhaHorariosAlunos>(context);
  bool cursoAtivo = provider.idFormacaoSelecionada != null ? true : false;
  return GestureDetector(
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
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            height: cursoAtivo ? Padroes.alturaGeral() * 0.07 : 0,
            child: cursoAtivo
                ? ListView.builder(
                    physics: Padroes.efeitoDeRolagem(),
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.listaNivelFormacao.length,
                    itemBuilder: (context, index) => quadradosSelecionaveis(
                        provider
                            .listaNivelFormacao[index].ofertaFormacao['nome']!,
                        provider))
                : null,
          ),
        ],
      ),
    ),
  );
}

Widget CardTurma(BuildContext context) {
  final provider = Provider.of<EscolhaHorariosAlunos>(context);
  bool turmaAtiva = provider.cursoSelecionado != null ? true : false;
  return GestureDetector(
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
                  'Turma',
                  style: estiloTexto(15),
                ),
                Transform.rotate(
                  angle: turmaAtiva ? 3.14 : 0,
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
            height: turmaAtiva ? Padroes.alturaGeral() * 0.07 : 0,
            child: turmaAtiva
                ? ListView.builder(
                    physics: Padroes.efeitoDeRolagem(),
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.listaNivelFormacao.length,
                    itemBuilder: (context, index) => quadradosSelecionaveis(
                        provider
                            .listaNivelFormacao[index].ofertaFormacao['nome']!,
                        provider))
                : null,
          ),
        ],
      ),
    ),
  );
}

Widget quadradosSelecionaveis(String opcoes, EscolhaHorariosAlunos provider) {
  return GestureDetector(
    onTap: () => {provider.selecionarFormacao(opcoes)},
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.only(bottom: 15, right: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: CoresClaras.cinzaBordas),
      ),
      child: Text(opcoes),
    ),
  );
}
