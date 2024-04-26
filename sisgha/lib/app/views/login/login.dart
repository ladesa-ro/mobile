import 'package:flutter/material.dart';
import 'package:sisgha/app/constants/estilos.dart';
import 'package:sisgha/app/constants/imagens.dart';
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
    double larguraTela = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              elementoVerde(Alignment.topLeft, 140, 110),
              elementoVerde(Alignment.bottomRight, 140, 110),
              formularioLogin(larguraTela),
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(ImageApp.logo_sisgha, height: 100),
                const SizedBox(height: 35),
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
                            SizedBox(height: 16),
                            _campoDeEntradaSenha('Senha', TextInputType.text,
                                senhaController, _mostrarErroSenha),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                      recuperarSenha(context),
                      const SizedBox(height: 20),
                      botaoEntrar('Entrar', context, formKey,
                          matriculaController, senhaController),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                botaoEntrarAluno(context),
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
