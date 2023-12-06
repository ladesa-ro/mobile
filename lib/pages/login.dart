import 'package:flutter/material.dart';

class PaginaLogin extends StatefulWidget {
  const PaginaLogin({Key? key}) : super(key: key);

  @override
  State<PaginaLogin> createState() => _EstadoPaginaLogin();
}

class _EstadoPaginaLogin extends State<PaginaLogin> {
  // Variável de estado para controlar a visibilidade da senha
  bool _senhaVisivel = true;

  // Cor personalizada RGB
  final Color corPersonalizada = const Color.fromRGBO(154, 182, 158, 1);

  // Função para alternar a visibilidade da senha
  void _alternarVisibilidadeSenha() {
    setState(() {
      _senhaVisivel = !_senhaVisivel;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Obtém a largura da tela
    double larguraTela = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              // Ícone verde do background
              _elementoVerde(Alignment.topLeft, 140, 110),
              // Ícone verde no canto inferior direito
              _elementoVerde(Alignment.bottomRight, 140, 110),
              // Formulário de login
              _formularioLogin(larguraTela),
            ],
          ),
        ),
      ),
    );
  }

// Widget para elementos verdes com arredondamento interno
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

  // Widget para receber os formulários e botões
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
                // Logo do SISGHA
                Image.asset(
                  'img/logo_sisgha.png',
                  height: 100,
                ),
                const SizedBox(height: 10),
                // Campo de entrada para Matrícula
                _campoDeEntrada('Matrícula', TextInputType.text),
                const SizedBox(height: 10),
                // Campo de entrada para Senha com alternador de visibilidade
                _campoDeEntradaSenha('Senha', TextInputType.visiblePassword),
                const SizedBox(height: 10),
                // Recuperação de senha
                _recuperarSenha(),
                const SizedBox(height: 40),
                // Botão de entrar
                _botaoEntrar(),
                const SizedBox(height: 40),
                // Botão de Entrar como aluno
                _botaoEntrarAluno(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget para campos de entrada de texto padrão
  Widget _campoDeEntrada(String labelText, TextInputType inputType) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        contentPadding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
        alignLabelWithHint: true,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: corPersonalizada,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(13),
          ),
        ),
        labelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: corPersonalizada,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(13),
          ),
          borderSide: BorderSide(
            color: corPersonalizada,
          ),
        ),
      ),
      keyboardType: inputType,
    );
  }

  // Widget para campo de entrada de senha com alternador de visibilidade
  Widget _campoDeEntradaSenha(String labelText, TextInputType inputType) {
    return TextFormField(
      obscureText: _senhaVisivel,
      decoration: InputDecoration(
        labelText: labelText,
        contentPadding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
        alignLabelWithHint: true,
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(13),
          ),
          borderSide: BorderSide(
            color: corPersonalizada,
          ),
        ),
        suffixIcon: IconButton(
          onPressed: _alternarVisibilidadeSenha,
          icon: Icon(
            _senhaVisivel
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
        ),
        labelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: corPersonalizada,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(13),
          ),
          borderSide: BorderSide(
            color: corPersonalizada,
          ),
        ),
      ),
      keyboardType: inputType,
    );
  }

  // Widget para a seção de recuperação de senha
  Widget _recuperarSenha() {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Esqueceu a senha?',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: corPersonalizada,
              fontSize: 13,
            ),
          ),
          const SizedBox(width: 3),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/home'),
            child: const Text(
              'Clique aqui',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(57, 160, 72, 1),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget para o botão de entrar
  Widget _botaoEntrar() {
    return FilledButton(
      onPressed: () => Navigator.pushNamed(context, '/home'),
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.fromLTRB(0, 20, 0, 20),
        ),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          const Color.fromRGBO(57, 160, 72, 1),
        ),
      ),
      child: const Text(
        'Entrar',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  // Widget para o botão de entrar como aluno
  Widget _botaoEntrarAluno() {
    return FilledButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.fromLTRB(15, 15, 0, 15),
        ),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          const Color.fromRGBO(57, 160, 72, 1),
        ),
      ),
      onPressed: () => Navigator.pushNamed(context, '/home'),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.person),
          SizedBox(width: 10),
          Text(
            '|',
            style: TextStyle(fontSize: 25),
          ),
          SizedBox(width: 20),
          Text(
            'Entrar como Aluno',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
