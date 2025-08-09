// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/estilos.dart';
import '../../../core/utils/imagens.dart';
import '../../../core/utils/padroes.dart';
import '../../../repository/repository.dart';
import '../../../viewmodels/dados_professor.dart';
import '../../../widgets/progress_indicator.dart';
import '../../../widgets/widget_erro.dart';
import 'widgets_estilos.dart';

class PaginaLogin extends StatelessWidget {
  const PaginaLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          elementoVerde(Alignment.topLeft),
          elementoVerde(Alignment.bottomRight),
          CorpoLogin()
        ],
      ),
    );
  }
}

class CorpoLogin extends StatefulWidget {
  const CorpoLogin({super.key});

  @override
  State<CorpoLogin> createState() => _CorpoLoginState();
}

class _CorpoLoginState extends State<CorpoLogin> {
  final TextEditingController matriculaController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _senhaVisivel = true;

  void alternarVisibilidadeSenha() {
    setState(() {
      _senhaVisivel = !_senhaVisivel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: SizedBox(
          height: Padroes.alturaGeral(),
          width: Padroes.larguraGeral(),
          child: Padding(
            padding: Padroes.margem() * 2.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  ImageApp.logo_sigha_sem_barra,
                  width: Padroes.larguraGeral() -
                      (Padroes.margem().horizontal * 4),
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(height: Padroes.alturaGeral() * 0.03),
                      inputMatricula(),
                      SizedBox(height: Padroes.alturaGeral() * 0.02),
                      inputSenha(),
                      SizedBox(height: Padroes.alturaGeral() * 0.01),
                      recuperarSenha(context),
                      SizedBox(height: Padroes.alturaGeral() * 0.01),
                      botaoEntrar(context),
                      SizedBox(height: Padroes.alturaGeral() * 0.02),
                      botaoEntrarAluno(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget botaoEntrarAluno(BuildContext context) {
    return ElevatedButton(
      style: Padroes.estiloBotao(context),
      onPressed: () => Navigator.pushNamed(context, "/acessoAluno"),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 19),
            Icon(
              Icons.person,
              //Faz o L
              //YURIIIIIII COMO MEXE NESSA PORCARIA MANOOOOOOOOO
              //Deixei por enquanto esse ícone aqui pra conseguir representar o ícone como cheio (falhei miseravelmente em tentar concertar o outro).
              //Yuri: kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk fluter 2 x braga 0
              color: CoresClaras.branco,
              size: 3.7.h,
            ),
            const SizedBox(width: 10),
            Container(
              width: 2,
              height: 3.h,
              color: CoresClaras.branco,
            ),
            const Spacer(),
            Text(
              'Entrar como Aluno',
              style: estiloTexto(16, peso: FontWeight.w600),
            ),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }

  FilledButton botaoEntrar(BuildContext context) {
    return FilledButton(
      onPressed: () async {
        FocusScopeNode currentFocus = FocusScope.of(context);

        // valida os campos
        if (formKey.currentState!.validate()) {
          // mostra o dialogo
          _mostrarDialogoDeCarregamento(context);

          try {
            // tempo limite para funcionar
            bool deuCerto =
                await Repository.login(matriculaController, senhaController)
                    .timeout(const Duration(seconds: 7));

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }

            if (deuCerto) {
              await context
                  .read<DadosProfessor>()
                  .iniciarProvider(context, false);
            } else {
              Navigator.of(context).pop(); // Fecha o loading
              senhaController.clear();
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          } on TimeoutException catch (_) {
            Navigator.of(context).pop();
            showDialog(
                context: context, builder: (context) => dialogoDeErro(context));
          } catch (e) {
            Navigator.of(context).pop();
            showDialog(
                context: context, builder: (context) => dialogoDeErro(context));
          }
        }
      },
      style: Padroes.estiloBotao(context),
      child: SizedBox(
        height: Padroes.aluturaBotoes(),
        width: Padroes.larguraGeral(),
        child: Center(
          child: Text(
            'Entrar',
            style: estiloTexto(16, cor: Colors.white, peso: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Container recuperarSenha(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Esqueceu a senha?',
            style: estiloTexto(
              cor: CoresClaras.verdecinza,
              14,
              peso: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 3),
          GestureDetector(
            onTap: () {
              Repository.teste();
            },
            child: Text(
              'Clique aqui',
              style: estiloTexto(15,
                  cor: CoresClaras.verdePrincipal, peso: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  TextFormField inputMatricula() {
    return TextFormField(
      controller: matriculaController,
      decoration: inputDecoration(context, 'Matrícula'),
      validator: (value) =>
          verificacao(value, 'Campo Obrigatorio', text2: 'Matrícula Inválida'),
      keyboardType: TextInputType.number,
    );
  }

  TextFormField inputSenha() {
    return TextFormField(
      controller: senhaController,
      decoration: inputDecoration(context, 'Senha',
          suffixIcon:
              iconeVisibilidadeSenha(alternarVisibilidadeSenha, _senhaVisivel)),
      validator: (value) => verificacao(value, 'Campo Obrigatorio'),
      keyboardType: TextInputType.text,
      obscureText: _senhaVisivel,
    );
  }

  dynamic verificacao(dynamic value, String text1, {String? text2}) {
    if (value == null || value.isEmpty) {
      setState(() {});
      return text1;
    } else if (text2 != null && value.contains(" ")) {
      setState(() {});
      return text2;
    } else {
      setState(() {});
      return null;
    }
  }

  static void _mostrarDialogoDeCarregamento(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => const AlertDialog(
        content: Progressindicator(tamanho: 200),
      ),
    );
  }
}
