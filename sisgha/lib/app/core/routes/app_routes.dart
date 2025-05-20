import 'package:flutter/cupertino.dart';
import 'package:sisgha/app/views/aluno/selecionar_turma/filtragem_de_turmas.dart';
import 'package:sisgha/app/views/login/boas_vindas.dart';
import 'package:sisgha/app/views/professor/calendario/calendario.dart';
import 'package:sisgha/app/views/professor/home/home.dart';
import 'package:sisgha/app/views/notificacao/notificacao.dart';
import 'package:sisgha/app/views/components/botton_app_bar.dart';
import 'package:sisgha/app/views/login/login/login.dart';
import 'package:sisgha/app/views/professor/perfil/perfil.dart';
import 'package:sisgha/app/views/login/splash_screen.dart';

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
      '/notificacao': (context) => const Notificacao()
    };
  }
}
