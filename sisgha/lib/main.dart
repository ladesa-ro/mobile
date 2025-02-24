import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/app/core/utils/theme_app.dart';
import 'package:sisgha/app/core/routes/app_routes.dart';
import 'package:sisgha/app/data/providers/dados_professor.dart';
import 'package:sisgha/app/data/providers/escolha_horarios_alunos.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DadosProfessor()),
        ChangeNotifierProvider(create: (_) => EscolhaHorariosAlunos())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return LayoutBuilder(
      builder: (context, constraints) {
        Device.setScreenSize(
            context,
            constraints,
            MediaQuery.of(context).orientation,
            constraints.maxWidth,
            constraints.minWidth);

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'SISGHA',
          theme: ThemeApp.tema(),
          initialRoute: '/primeiraTela',
          routes: AppRoutes.rotas(),
        );
      },
    );
  }
}
