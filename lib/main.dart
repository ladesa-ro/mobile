import 'package:flutter/material.dart';
import 'package:login_page/pages/home.dart';
import 'package:login_page/pages/login.dart';

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
              seedColor: const Color.fromRGBO(57, 160, 72, 1)),
          useMaterial3: true,
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => const PaginaLogin(),
          '/home': (context) => const Home()
        });
  }
}
