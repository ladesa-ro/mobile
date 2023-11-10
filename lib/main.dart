import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login SISGHA',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const PaginaLogin(),
    );
  }
}

class PaginaLogin extends StatefulWidget {
  const PaginaLogin({super.key});

  @override
  State<PaginaLogin> createState() => _EstadoPaginaLogin();
}

class _EstadoPaginaLogin extends State<PaginaLogin> {
  // Variável de estado para controlar a visibilidade da senha
  bool _senhaVisivel = true;

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
      body: Stack(
        children: [
          // Ícone verde do background
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 200,
              height: 170,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('img/icones-verdes.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Ícone verde no canto inferior direito
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 250,
              height: 180,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('img/icones-verdes1.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Formulário de login
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              width: larguraTela,
              height: 400,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5,
                    offset: Offset(0, 15),
                  ),
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 90, vertical: 20),
                child: Column(
                  children: [
                    // Logo do SISGHA
                    Image.asset('img/logo_sisgha.png'),
                    const SizedBox(height: 20),
                    // Campo de entrada para Matrícula
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Matrícula',
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Campo de entrada para Senha com alternador de visibilidade
                    TextFormField(
                      obscureText: _senhaVisivel,
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: _alternarVisibilidadeSenha,
                          icon: Icon(
                            _senhaVisivel
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                        labelStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
