import 'package:flutter/material.dart';

import 'login_form.dart';
import 'widgets_estilos.dart';

class PaginaLogin extends StatelessWidget {
  const PaginaLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).colorScheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          elementoVerde(Alignment.topLeft, tema),
          elementoVerde(Alignment.bottomRight, tema),
          LoginForm(),
        ],
      ),
    );
  }
}
