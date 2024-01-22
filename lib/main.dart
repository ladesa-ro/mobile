import 'package:flutter/material.dart';
import 'package:login_page/pages/calendario.dart';
import 'package:login_page/pages/home.dart';
import 'package:login_page/pages/login.dart';
import 'package:login_page/pages/navega%C3%A7%C3%A3o.dart';
import 'package:login_page/pages/perfil.dart';

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
        initialRoute: '/login',
        routes: {
          '/login': (context) => const PaginaLogin(),
          '/navegação': (context) => const Navigation(),
          '/home': (context) => const Home(),
          '/perfilProf': (context) => const Perfil(),
          '/calendario': (context) => const Calendar(),
        });
  }
}
