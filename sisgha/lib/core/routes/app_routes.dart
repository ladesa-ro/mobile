import 'package:flutter/cupertino.dart';
import 'package:sisgha/views/aluno/notificacao/notificacao.dart';
import 'package:sisgha/views/aluno/selecionar_turma/filtragem_de_turmas.dart';
import 'package:sisgha/views/inicializa%C3%A7%C3%A3o/boas_vindas.dart';
import 'package:sisgha/views/professor/calendario/calendario.dart';
import 'package:sisgha/views/professor/home/home.dart';
import 'package:sisgha/views/appbar_e_menu/menu_de_navegacao.dart';
import 'package:sisgha/views/login/login_page.dart';
import 'package:sisgha/views/professor/perfil/perfil.dart';
import 'package:sisgha/views/inicializa%C3%A7%C3%A3o/splash_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> rotas() {
    return {
      '/bemvindo': (context) => const BoasVindasPage(),
      '/login': (context) => const PaginaLogin(),
      '/navegação': (context) => const Navigation(initialIndex: 1),
      '/home': (context) => const Home(),
      '/perfilProf': (context) => const Perfil(),
      '/calendario': (context) => CalendarioProfessor(),
      '/primeiraTela': (context) => const SplashScreen(),
      '/acessoAluno': (context) => const FiltrargemDeTurmas(),
      '/notificacao': (context) => const Notificacao(
            voltarProfessores: true,
          )
    };
  }
}
