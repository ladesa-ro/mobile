import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste/app/views/home/home.dart';
import 'package:teste/app/views/login/aluno.dart';
import 'package:teste/app/views/estilos.dart';
import 'package:http/http.dart' as http;

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
  final Color corPersonalizada = const Color.fromRGBO(154, 182, 158, 1);

  void _alternarVisibilidadeSenha() {
    setState(() {
      _senhaVisivel = !_senhaVisivel;
    });
  }

  bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    return int.tryParse(s) != null;
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
              _elementoVerde(Alignment.topLeft, 140, 110),
              _elementoVerde(Alignment.bottomRight, 140, 110),
              _formularioLogin(larguraTela),
            ],
          ),
        ),
      ),
    );
  }

  Widget _elementoVerde(Alignment alignment, double width, double height) {
    BorderRadiusGeometry borderRadius = BorderRadius.zero;
    if (alignment == Alignment.topLeft) {
      borderRadius = const BorderRadius.only(
        bottomRight: Radius.circular(2000),
      );
    } else if (alignment == Alignment.bottomRight) {
      borderRadius = const BorderRadius.only(
        topLeft: Radius.circular(2000),
      );
    }

    return Align(
      alignment: alignment,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(57, 160, 72, 1),
              Color.fromRGBO(0, 208, 71, 1),
            ],
          ),
          borderRadius: borderRadius,
        ),
      ),
    );
  }

  Widget _formularioLogin(double larguraTela) {
    return Center(
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: SizedBox(
          width: larguraTela > 800 ? 800 : larguraTela,
          height: 800,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset('img/logo_sisgha.png', height: 100),
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
                      _recuperarSenha(),
                      const SizedBox(height: 20),
                      _botaoEntrar('Entrar'),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                _botaoEntrarAluno(),
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
        decoration: _inputDecoration(labelText),
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
        decoration:
            _inputDecoration(labelText, suffixIcon: _iconeVisibilidadeSenha()),
        keyboardType: inputType,
      ),
    );
  }

  Widget _recuperarSenha() {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Esqueceu a senha?',
              style: estiloTexto(
                cor: const Color.fromRGBO(154, 182, 158, 1),
                13,
                peso: FontWeight.w600,
              )),
          const SizedBox(width: 3),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/home'),
            child: Text('Clique aqui',
                style: estiloTexto(13,
                    cor: const Color.fromRGBO(57, 160, 72, 1),
                    peso: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Widget _botaoEntrar(String texto) {
    return FilledButton(
      onPressed: () async {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (formKey.currentState!.validate()) {
          bool deuCerto = await login();
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
          if (deuCerto) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Home(),
                ));
          } else {
            senhaController.clear();
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        }
      },
      style: estiloBotao(context),
      child: Container(
        width: double.infinity,
        child: Center(
          child: Text(
            texto,
            style: estiloTexto(15, cor: Colors.white, peso: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Widget _botaoEntrarAluno() {
    return SizedBox(
      height: 45,
      child: FilledButton(
        style: estiloBotao(context),
        onPressed: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const PaginaAluno(),
            ),
            (route) => false),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(width: 15),
              Icon(Icons.person),
              SizedBox(width: 10),
              Text('|', style: TextStyle(fontSize: 20)),
              SizedBox(width: 20),
              Text('Entrar como Aluno',
                  style: estiloTexto(15, peso: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String labelText, {Widget? suffixIcon}) {
    return InputDecoration(
      labelText: labelText,
      contentPadding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      alignLabelWithHint: true,
      border: _inputBorder(),
      labelStyle: estiloTexto(14, cor: corPersonalizada, peso: FontWeight.w600),
      focusedBorder: _inputBorder(),
      suffixIcon: suffixIcon,
    );
  }

  OutlineInputBorder _inputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: corPersonalizada),
      borderRadius: const BorderRadius.all(Radius.circular(13)),
    );
  }

  Widget _iconeVisibilidadeSenha() {
    return IconButton(
      onPressed: _alternarVisibilidadeSenha,
      icon: Icon(_senhaVisivel
          ? Icons.visibility_outlined
          : Icons.visibility_off_outlined),
    );
  }

  Future<bool> login() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse("https://luna.sisgha.com/api/autenticacao/login");
    var resposta = await http.post(url, body: {
      "matriculaSiape": matriculaController.text,
      "senha": senhaController.text,
    });
    if (resposta.statusCode == 201) {
      await sharedPreferences.setString(
          'token', "Token ${jsonDecode(resposta.body)['access_token']}");
      return true;
    } else {
      return false;
    }
  }

  final snackBar = const SnackBar(
    content: Text(
      "Matricula ou senha inválidos",
      textAlign: TextAlign.center,
    ),
  );
}
