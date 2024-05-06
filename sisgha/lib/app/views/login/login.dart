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
  TextEditingController matriculaController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  bool _mostrarErroMatricula = false;
  bool _mostrarErroSenha = false;
  bool _senhaVisivel = true;
  final formKey = GlobalKey<FormState>();

  void alternarVisibilidadeSenha() {
    setState(() {
      _senhaVisivel = !_senhaVisivel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              elementoVerde(Alignment.topLeft, TamanhoTela.horizontal(context),
                  TamanhoTela.vertical(context)),
              elementoVerde(
                  Alignment.bottomRight,
                  TamanhoTela.horizontal(context),
                  TamanhoTela.vertical(context)),
              formularioLogin(TamanhoTela.horizontal(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget formularioLogin(double larguraTela) {
    return Center(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SizedBox(
          width: larguraTela > 800 ? 800 : larguraTela,
          height: 800,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            child: Column(
              children: [
                SizedBox(height: TamanhoTela.vertical(context) * 0.20),
                Image.asset(ImageApp.logo_sisgha,
                    width: TamanhoTela.horizontal(context) * 0.75),
                SizedBox(height: TamanhoTela.vertical(context) * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            _campoDeEntrada('Matrícula', TextInputType.number,
                                matriculaController, _mostrarErroMatricula),
                            SizedBox(
                                height: TamanhoTela.vertical(context) * 0.02),
                            _campoDeEntradaSenha('Senha', TextInputType.text,
                                senhaController, _mostrarErroSenha),
                            SizedBox(
                                height: TamanhoTela.vertical(context) * 0.02),
                          ],
                        ),
                      ),
                      recuperarSenha(context),
                      SizedBox(height: TamanhoTela.vertical(context) * 0.02),
                      botaoEntrar('Entrar', context, formKey,
                          matriculaController, senhaController),
                    ],
                  ),
                ),
                SizedBox(height: TamanhoTela.vertical(context) * 0.02),
                botaoEntrarAluno(context),
                SizedBox(height: TamanhoTela.vertical(context) * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _campoDeEntrada(String labelText, TextInputType inputType,
      TextEditingController controller, bool mostrarErro) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: mostrarErro ? 60 : 40,
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
            return "Matricula incorreta";
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
      duration: Duration(milliseconds: 300),
      height: mostrarErro ? 60 : 40,
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
