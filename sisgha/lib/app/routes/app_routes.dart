import 'package:flutter/cupertino.dart';
import 'package:sisgha/app/views/aluno/selecionar_turma.dart';
import 'package:sisgha/app/views/inicio/boasvindas.dart';
import 'package:sisgha/app/views/calendario/calendario.dart';
import 'package:sisgha/app/views/home/home.dart';
import 'package:sisgha/app/views/home/navegacao.dart';
import 'package:sisgha/app/views/login/login.dart';
import 'package:sisgha/app/views/perfil/perfil.dart';
import 'package:sisgha/app/views/inicio/splashScreen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> rotas() {
    return {
      '/bemvindo': (context) => const BoasVindasPage(),
      '/login': (context) => const PaginaLogin(),
      '/navegação': (context) => const Navigation(initialIndex: 1),
      '/home': (context) => const Home(),
      '/perfilProf': (context) => const Perfil(),
      '/calendario': (context) => const Calendar(),
      '/primeiraTela': (context) => const SplashScreen(),
      '/acessoAluno': (context) => const PaginaAlunoSelec(),
    };
  }
}
