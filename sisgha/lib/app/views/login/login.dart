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

  bool _mostrarErroMatricula = false;
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
                  width: larguraTela > 700 ? 800 : larguraTela,
                  height: 800,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal:
                            TamanhoTela.vertical(context) > 1000 ? 70 : 50,
                        vertical: 20),
                    child: Column(
                      children: [
                        const Spacer(),
                        Image.asset(
                          ImageApp.logo_sigha_sem_barra,
                          width: 250,
                        ),
                        const SizedBox(height: 30),
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
                                    _mostrarErroMatricula),
                                const SizedBox(height: 20),
                                _campoDeEntradaSenha(
                                    'Senha',
                                    TextInputType.text,
                                    senhaController,
                                    _mostrarErroSenha),
                                const SizedBox(height: 20),
                                recuperarSenha(context),
                                const SizedBox(height: 20),
                                botaoEntrar('Entrar', context, formKey,
                                    matriculaController, senhaController),
                                const SizedBox(height: 30),
                              ],
                            ),
                          ),
                        ),
                        botaoEntrarAluno(context),
                        SizedBox(
                            height: TamanhoTela.vertical(context) > 810
                                ? 0
                                : TamanhoTela.vertical(context) * 0.13),
                        const Spacer(),
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
      TextEditingController controller, bool mostrarErro) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: mostrarErro ? 70 : 50,
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            setState(() {
              _mostrarErroMatricula = true;
            });
            return "Campo obrigatório";
          } else if (value.contains(" ")) {
            setState(() {
              _mostrarErroMatricula = true;
            });
            return "Matrícula incorreta";
          } else {
            setState(() {
              _mostrarErroMatricula = false;
            });
            return null;
          }
        },
        decoration: inputDecoration(labelText),
        keyboardType: inputType,
      ),
    );
  }

  Widget _campoDeEntradaSenha(String labelText, TextInputType inputType,
      TextEditingController controller, bool mostrarErro) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: mostrarErro ? 70 : 50,
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            setState(() {
              _mostrarErroSenha = true;
            });
            return "Campo obrigatório";
          } else {
            setState(() {
              _mostrarErroSenha = false;
            });
            return null;
          }
        },
        obscureText: _senhaVisivel,
        decoration: inputDecoration(labelText,
            suffixIcon: iconeVisibilidadeSenha(
                alternarVisibilidadeSenha, _senhaVisivel)),
        keyboardType: inputType,
      ),
    );
  }
}
