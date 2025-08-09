import 'package:flutter/cupertino.dart';
import 'package:sisgha/views/aluno/notificacao/notificacoes_alunos.dart';
import 'package:sisgha/views/aluno/selecionar_turma/filtragem_de_turmas.dart';
import 'package:sisgha/views/inicio/boas_vindas.dart';
import 'package:sisgha/views/professor/calendario/calendario.dart';
import 'package:sisgha/views/professor/home/home.dart';
import 'package:sisgha/widgets/botton_app_bar.dart';
import 'package:sisgha/views/login/login/login_page.dart';
import 'package:sisgha/views/professor/perfil/perfil.dart';
import 'package:sisgha/views/inicio/splash_screen.dart';

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
      '/notificacao': (context) => const NotificacoesAlunos()
    };
  }
}
