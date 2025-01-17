import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/app/core/utils/theme_app.dart';
import 'package:sisgha/app/core/routes/app_routes.dart';
import 'package:sisgha/app/data/providers/dados_professor.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => DadosProfessor())],
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
          600, // maxMobileWidth
          900, // maxTabletWidth
        );

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'SISGHA',
          theme: ThemeApp.Tema(),
          initialRoute: '/primeiraTela',
          routes: AppRoutes.rotas(),
        );
      },
    );
  }
}
