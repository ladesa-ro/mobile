// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../repository/repository.dart';
import '../../viewmodels/dados_professor.dart';
import '../../widgets/widget_erro.dart';
import 'login/widgets_estilos.dart';

class LoginViewModel extends ChangeNotifier {
  bool senhaVisivel = false;

  void alternarVisibilidadeSenha() {
    senhaVisivel = !senhaVisivel;
    notifyListeners();
  }

  Future<void> verificarLogin(TextEditingController matricula,
      TextEditingController senha, BuildContext context) async {
    try {
      bool deuCerto = await Repository.login(matricula, senha)
          .timeout(const Duration(seconds: 7));
      if (deuCerto) {
        await context.read<DadosProfessor>().iniciarProvider(context, false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } on TimeoutException {
      Navigator.of(context).pop();
      showDialog(context: context, builder: (_) => dialogoDeErro(context));
    } catch (_) {
      Navigator.of(context).pop();
      showDialog(context: context, builder: (_) => dialogoDeErro(context));
    }
  }
}
