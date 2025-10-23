import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/core/theme/tema_provider.dart';
import 'package:sisgha/viewmodels/calendario_funcionalidades.dart';
import 'package:sisgha/core/routes/app_routes.dart';
import 'package:sisgha/viewmodels/dados_ensino_professor_provider.dart';
import 'package:sisgha/viewmodels/dados_professor.dart';
import 'package:sisgha/viewmodels/escolha_horarios_alunos.dart';
import 'package:sisgha/views/login/login_viewmodel.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DadosProfessor()),
        ChangeNotifierProvider(create: (_) => EscolhaHorariosAlunos()),
        ChangeNotifierProvider(create: (_) => TemasProvider()),
        ChangeNotifierProvider(create: (_) => CalendarioFuncionalidades()),
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => DadosEnsinoProfessorProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final temaProvider = Provider.of<TemasProvider>(context);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Sizer(
      builder: (context, orientation, devicetype) {
        return MaterialApp(
          showPerformanceOverlay: false,
          debugShowCheckedModeBanner: false,
          title: 'SISGHA',
          theme: temaProvider.temaAtivo,
          initialRoute: '/primeiraTela',
          routes: AppRoutes.rotas(),
        );
      },
    );
  }
}
