import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sisgha/app/constants/colors.dart';

import 'package:sisgha/app/constants/tamanhoTela.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  bool temporizador = false;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      setState(() {
        temporizador = true;
      });

      Future.delayed(const Duration(milliseconds: 1300), () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/bemvindo',
          (route) => false,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 0,
              left: 50,
              right: 50,
              bottom: 150,
              child: Image.asset(
                'assets/img/Logomarca-Teste.png',
                width: TamanhoTela.horizontal(context) * 0.75,
              )),
          Positioned(
            top: 0,
            left: 0,
            child: AnimatedContainer(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [ColorApp.VerdeClaro, ColorApp.VerdeEscuro],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(
                      TamanhoTela.vertical(context) < 700 ? 80 : 100),
                ),
              ),
              duration: const Duration(milliseconds: 1200),
              curve: Curves.linear,
              height: temporizador
                  ? MediaQuery.sizeOf(context).height
                  : MediaQuery.sizeOf(context).height * 0.20,
              width: temporizador
                  ? MediaQuery.sizeOf(context).width
                  : MediaQuery.sizeOf(context).width * 0.35,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: AnimatedContainer(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [ColorApp.VerdeEscuro, ColorApp.VerdeClaro],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                      TamanhoTela.vertical(context) < 700 ? 80 : 100),
                ),
              ),
              duration: const Duration(milliseconds: 1200),
              curve: Curves.linear,
              height: temporizador
                  ? MediaQuery.sizeOf(context).height
                  : MediaQuery.sizeOf(context).height * 0.20,
              width: temporizador
                  ? MediaQuery.sizeOf(context).width
                  : MediaQuery.sizeOf(context).width * 0.35,
            ),
          ),
        ],
      ),
    );
  }
}
