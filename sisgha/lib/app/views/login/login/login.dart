// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sizer/sizer.dart';

import '../../../core/utils/Icones.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/estilos.dart';
import '../../../core/utils/imagens.dart';
import '../../../core/utils/responsividade.dart';
import '../../../core/utils/tamanhos.dart';
import '../../../domain/api/repository.dart';
import '../../../data/providers/dados_professor.dart';
import '../../components/widget_erro.dart';
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
          height: TamanhoTela.vertical(context),
          width: TamanhoTela.horizontal(context),
          child: Padding(
            padding: Tamanhos.margem() * 2.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  ImageApp.logo_sigha_sem_barra,
                  width: TamanhoTela.horizontal(context) -
                      (Tamanhos.margem().horizontal * 4),
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(height: TamanhoTela.vertical(context) * 0.03),
                      inputMatricula(),
                      SizedBox(height: TamanhoTela.vertical(context) * 0.02),
                      inputSenha(),
                      SizedBox(height: TamanhoTela.vertical(context) * 0.01),
                      recuperarSenha(context),
                      SizedBox(height: TamanhoTela.vertical(context) * 0.01),
                      botaoEntrar(context),
                      SizedBox(height: TamanhoTela.vertical(context) * 0.02),
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
      style: Tamanhos.estiloBotao(),
      onPressed: () => Navigator.pushNamed(context, "/acessoAluno"),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 19),
            Icon(
              Icones.PersonCheio,
              color: CoresClaras.branco,
              size: 3.h,
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
        if (formKey.currentState!.validate()) {
          bool deuCerto =
              await Repository.login(matriculaController, senhaController);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
          if (deuCerto) {
            await context.read<DadosProfessor>().iniciarProvider(context);
          } else {
            senhaController.clear();
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        }
      },
      style: Tamanhos.estiloBotao(),
      child: SizedBox(
        height: Tamanhos.aluturaBotoes(),
        width: Tamanhos.larguraGeral(),
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
            onTap: () => showDialog(
              context: context,
              builder: (context) => dialogoDeErro(context, 'login'),
            ),
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
}
