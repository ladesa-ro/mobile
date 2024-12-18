import 'package:flutter/material.dart';
import 'package:sisgha/app/constants/estilos.dart';
import 'package:sisgha/app/constants/imagens.dart';
import 'package:sisgha/app/constants/tamanhoTela.dart';
import 'package:sisgha/app/widgets/widgtes_login.dart';

class PaginaLogin extends StatefulWidget {
  const PaginaLogin({Key? key}) : super(key: key);

  @override
  State<PaginaLogin> createState() => _EstadoPaginaLogin();
}

class _EstadoPaginaLogin extends State<PaginaLogin> {
  final TextEditingController matriculaController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final bool _mostrarErroMatricula = false;
  bool _mostrarErroSenha = false;
  bool _senhaVisivel = true;

  void alternarVisibilidadeSenha() {
    setState(() {
      _senhaVisivel = !_senhaVisivel;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double larguraTela = TamanhoTela.horizontal(context);
    final double alturaTela = TamanhoTela.vertical(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: MediaQuery.removeViewInsets(
        removeTop: true,
        context: context,
        child: Stack(
          children: [
            elementoVerde(Alignment.topLeft, larguraTela, alturaTela),
            elementoVerde(Alignment.bottomRight, larguraTela, alturaTela),
            Center(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: larguraTela,
                  height: alturaTela,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: larguraTela * 0.08),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: alturaTela * 0.1,
                          child: Image.asset(
                            ImageApp.logo_sigha_sem_barra,
                            width: larguraTela * 0.6,
                          ),
                        ),
                        SizedBox(height: alturaTela * 0.03),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                _campoDeEntrada(
                                    'Matrícula',
                                    TextInputType.number,
                                    matriculaController,
                                    alturaTela),
                                _campoDeEntradaSenha(
                                    'Senha',
                                    TextInputType.text,
                                    senhaController,
                                    alturaTela),
                                recuperarSenha(context),
                                SizedBox(height: alturaTela * 0.03),
                                botaoEntrar(
                                    'Entrar',
                                    context,
                                    formKey,
                                    matriculaController,
                                    senhaController,
                                    alturaTela),
                                SizedBox(height: alturaTela * 0.03),
                                botaoEntrarAluno(
                                    context, alturaTela, larguraTela),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _campoDeEntrada(String labelText, TextInputType inputType,
      TextEditingController controller, double altura) {
    return AnimatedContainer(
      margin: EdgeInsets.only(bottom: 7),
      duration: const Duration(milliseconds: 300),
      height: altura * 0.07,
      child: TextFormField(
        controller: controller,
        validator: (value) => verificacao(value, "Campo obrigatorio",
            text2: "Matricula invalida"),
        decoration: inputDecoration(labelText),
        keyboardType: inputType,
      ),
    );
  }

  Widget _campoDeEntradaSenha(String labelText, TextInputType inputType,
      TextEditingController controller, double altura) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: altura * 0.07,
      margin: EdgeInsets.only(bottom: 7),
      child: TextFormField(
        controller: controller,
        validator: (value) => verificacao(value, "Campo Obrigatorio"),
        obscureText: _senhaVisivel,
        decoration: inputDecoration(labelText,
            suffixIcon: iconeVisibilidadeSenha(
                alternarVisibilidadeSenha, _senhaVisivel)),
        keyboardType: inputType,
      ),
    );
  }

  dynamic verificacao(dynamic value, String text1, {String? text2}) {
    if (value == null || value.isEmpty) {
      setState(() {
        _mostrarErroSenha = true;
      });
      return text1;
    } else if (text2 != null && value.contains(" ")) {
      setState(() {
        _mostrarErroSenha = true;
      });
      return text2;
    } else {
      setState(() {
        _mostrarErroSenha = false;
      });
      return null;
    }
  }
}
