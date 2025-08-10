import 'package:flutter/material.dart';

import 'login_form.dart';
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
          LoginForm(),
        ],
      ),
    );
  }
}
