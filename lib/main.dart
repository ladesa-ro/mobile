import 'package:flutter/material.dart';
import 'package:sisgha_mobile/pages/calendario/calendario.dart';
import 'package:sisgha_mobile/pages/home/home.dart';
import 'package:sisgha_mobile/pages/login/login.dart';
import 'package:sisgha_mobile/pages/navega%C3%A7%C3%A3o.dart';
import 'package:sisgha_mobile/pages/perfil/perfil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Login SISGHA',
        theme: ThemeData(
          fontFamily: 'Poppins',
          colorScheme: ColorScheme.fromSeed(
              primary: const Color.fromRGBO(57, 160, 72, 1),
              seedColor: const Color.fromRGBO(57, 160, 72, 1)),
          useMaterial3: true,
        ),
        initialRoute: '/navegação',
        routes: {
          '/login': (context) => const PaginaLogin(),
          '/navegação': (context) => const Navigation(),
          '/home': (context) => const Home(),
          '/perfilProf': (context) => const Perfil(),
          '/calendario': (context) => const Calendar(),
        });
  }
}
