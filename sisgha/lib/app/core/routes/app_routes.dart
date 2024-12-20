import 'package:flutter/cupertino.dart';
import 'package:sisgha/app/views/aluno/selecionar_turma/selecionar_turma.dart';
import 'package:sisgha/app/views/inicio/boas_vindas.dart';
import 'package:sisgha/app/views/calendario/calendario.dart';
import 'package:sisgha/app/views/home/home.dart';
import 'package:sisgha/app/views/widgets_globais/botton_app_bar.dart';
import 'package:sisgha/app/views/inicio/login/login.dart';
import 'package:sisgha/app/views/perfil/perfil.dart';
import 'package:sisgha/app/views/inicio/splash_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> rotas() {
    return {
      '/bemvindo': (context) => const BoasVindasPage(),
      '/login': (context) => const PaginaLogin(),
      '/navegação': (context) => const Navigation(initialIndex: 1),
      '/home': (context) => const Home(),
      '/perfilProf': (context) => const Perfil(),
      '/calendario': (context) => Calendar(),
      '/primeiraTela': (context) => const SplashScreen(),
      '/acessoAluno': (context) => const PaginaAlunoSelec(),
    };
  }
}
