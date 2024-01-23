import 'package:flutter/material.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class PaginaLogin extends StatefulWidget {
  const PaginaLogin({Key? key}) : super(key: key);

  @override
  State<PaginaLogin> createState() => _EstadoPaginaLogin();
}

class _EstadoPaginaLogin extends State<PaginaLogin> {
  bool _senhaVisivel = true;
  final formKey = GlobalKey<FormState>();
  final Color corPersonalizada = const Color.fromRGBO(154, 182, 158, 1);

  // Função para alternar a visibilidade da senha
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
                const SizedBox(height: 15),
                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        _campoDeEntrada('Matrícula', TextInputType.text),
                        const SizedBox(height: 10),
                        _campoDeEntradaSenha(
                            'Senha', TextInputType.visiblePassword),
                        const SizedBox(height: 10),
                      ],
                    )),
                _recuperarSenha(),
                const SizedBox(height: 40),
                _botaoEntrar('Entrar', '/navegação'),
                const SizedBox(height: 20),
                _botaoEntrarAluno(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _campoDeEntrada(String labelText, TextInputType inputType) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Este campo deve ser preenchido";
        } else if (value.length != 13) {
          return "A Matricula contém 11 dígitos numéricos";
        }
        return null;
      },
      decoration: _inputDecoration(labelText),
      keyboardType: inputType,
    );
  }

  Widget _campoDeEntradaSenha(String labelText, TextInputType inputType) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Este campo deve ser preenchido";
        } else if (value.length <= 5) {
          return "A senha deve ter mais de 5 caracteres";
        } else if (!value.contains(RegExp(r'[A-Z]'))) {
          return "Letra maiúscula necessária";
        } else if (!value.contains(RegExp(r'[a-z]'))) {
          return "Letra minúscula necessária";
        } else if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
          return "Caractere especial necessário";
        }
        return null;
      },
      obscureText: _senhaVisivel,
      decoration:
          _inputDecoration(labelText, suffixIcon: _iconeVisibilidadeSenha()),
      keyboardType: inputType,
    );
  }

  Widget _recuperarSenha() {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Esqueceu a senha?', style: _estiloTexto(13)),
          const SizedBox(width: 3),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/home'),
            child: Text('Clique aqui',
                style: _estiloTexto(13, cor: Color.fromRGBO(57, 160, 72, 1))),
          ),
        ],
      ),
    );
  }

  Widget _botaoEntrar(String texto, String rota) {
    return FilledButton(
      onPressed: () {
        if (formKey.currentState != null && formKey.currentState!.validate()) {
          Navigator.pushNamedAndRemoveUntil(context, rota, (route) => false);
        } else {
          print("Form invalido");
        }
      },
      style: _estiloBotao(),
      child: Text(
        texto,
        style: _estiloTexto(15, cor: Colors.white, peso: FontWeight.w600),
      ),
    );
  }

  Widget _botaoEntrarAluno() {
    return FilledButton(
      style: _estiloBotao(),
      onPressed: () =>
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 15),
          Icon(Icons.person),
          SizedBox(width: 10),
          Text('|', style: TextStyle(fontSize: 25)),
          SizedBox(width: 20),
          Text('Entrar como Aluno',
              style: _estiloTexto(15, peso: FontWeight.w600)),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String labelText, {Widget? suffixIcon}) {
    return InputDecoration(
      labelText: labelText,
      contentPadding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      alignLabelWithHint: true,
      border: _inputBorder(),
      labelStyle:
          _estiloTexto(14, cor: corPersonalizada, peso: FontWeight.w600),
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

  ButtonStyle _estiloBotao() {
    return ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.fromLTRB(0, 10, 0, 10)),
      shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
      backgroundColor: MaterialStateProperty.all<Color>(
          const Color.fromRGBO(57, 160, 72, 1)),
    );
  }

  TextStyle _estiloTexto(double tamanho, {Color? cor, FontWeight? peso}) {
    return TextStyle(
      fontSize: tamanho,
      color: cor,
      fontWeight: peso,
    );
  }
}
