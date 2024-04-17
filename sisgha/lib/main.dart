import 'package:flutter/material.dart';
import 'package:teste/app/views/boasvindas.dart';
import 'package:teste/app/views/calendario/calendario.dart';
import 'package:teste/app/views/home/home.dart';
import 'package:teste/app/views/login/login.dart';
import 'package:teste/app/views/home/navegacao.dart';
import 'package:teste/app/views/perfil/perfil.dart';

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
        initialRoute: '/bemvindo',
        routes: {
          '/bemvindo': (context) => const BoasVindasPage(),
          '/login': (context) => const PaginaLogin(),
          '/navegação': (context) => const Navigation(initialIndex: 0),
          '/home': (context) => const Home(),
          '/perfilProf': (context) => const Perfil(),
          '/calendario': (context) => const Calendar(),
        });
  }
}
