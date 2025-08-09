import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sisgha/core/utils/colors.dart';
import 'package:sisgha/viewmodels/dados_professor.dart';

import '../core/utils/estilos.dart';
import '../core/utils/imagens.dart';

Widget dialogoDeErro(BuildContext context) {
  DadosProfessor dadosProfessor = DadosProfessor();
  return AlertDialog(
    backgroundColor: Colors.white,
    content: FittedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          Image.asset(
            ImageApp.imagemErro,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Nenhuma conexão com a internet ',
            style:
                estiloTexto(16, cor: CoresClaras.preto, peso: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Verifique sua conexão ou',
            style: estiloTexto(
              15,
              cor: CoresClaras.preto,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'tente novamente',
            style: estiloTexto(
              15,
              cor: CoresClaras.preto,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
            style: _estiloBotao(CoresClaras.verdePrincipal, CoresClaras.branco),
            onPressed: () {
              dadosProfessor.apagarDados();
              Navigator.pushNamedAndRemoveUntil(
                context,
                "/login",
                (route) => false,
              );
            },
            child: const Text('Tente novamente'),
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
            style: _estiloBotao(CoresClaras.branco, CoresClaras.verdePrincipal),
            onPressed: () {
              dadosProfessor.apagarDados();
              SystemNavigator.pop();
            },
            child: const Text('Talvez mais tarde'),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    ),
  );
}

ButtonStyle _estiloBotao(Color corFundo, Color corTexto) {
  return ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(corFundo),
    foregroundColor: WidgetStatePropertyAll(corTexto),
    minimumSize: const WidgetStatePropertyAll(Size(300, 50)),
    maximumSize: const WidgetStatePropertyAll(Size(300, 50)),
    shape: WidgetStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    ),
  );
}
