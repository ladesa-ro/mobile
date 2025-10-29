// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/core/theme/tema.dart';
import 'package:sisgha/core/theme/tema_provider.dart';
import 'package:sisgha/viewmodels/calendario_funcionalidades.dart';
import 'package:sisgha/core/routes/app_routes.dart';
import 'package:sisgha/viewmodels/dados_ensino_professor_provider.dart';
import 'package:sisgha/viewmodels/dados_professor.dart';
import 'package:sisgha/viewmodels/escolha_horarios_alunos.dart';
import 'package:sisgha/views/login/login_viewmodel.dart';
import 'package:sizer/sizer.dart';

import 'domain/logic/tema_preferencia.dart';

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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    loadTheme();
  }

  void loadTheme() async {
    final themeStorage = TemaPreferencia();
    await themeStorage.buscarPrefernciaDeTema();

    context.read<TemasProvider>().carregarTemaSalvo(themeStorage.savedTheme);
  }

  @override
  Widget build(BuildContext context) {
    final temaProvider = context.watch<TemasProvider>();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Sizer(
      builder: (context, orientation, devicetype) {
        return MaterialApp(
          showPerformanceOverlay: false,
          debugShowCheckedModeBanner: false,
          title: 'SISGHA',
          theme: Temas.temaClaro,
          darkTheme: Temas.temaEscuro,
          themeMode: temaProvider.themeMode,
          initialRoute: '/primeiraTela',
          routes: AppRoutes.rotas(),
        );
      },
    );
  }
}
