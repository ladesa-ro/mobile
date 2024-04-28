import 'package:flutter/material.dart';
import 'package:sisgha/app/constants/colors.dart';
import 'package:sisgha/app/constants/theme_app.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..forward().whenComplete(() {
        Navigator.pushNamed(context, '/bemvindo');
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeApp.Tema(),
      home: Scaffold(
        body: Stack(
          children: [
            Center(
              child: Image.asset(
                'assets/img/logo_sisgha.png',
              ),
            ),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                double scale = _controller.value;
                double width = MediaQuery.of(context).size.width;
                double height = MediaQuery.of(context).size.height;

                return Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: _QuadradoCima(
                        ColorApp.VerdeClaro,
                        scale,
                        width,
                        height,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: _QuadradoBaixo(
                        ColorApp.VerdeClaro,
                        scale,
                        width,
                        height,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _QuadradoCima(
    Color color,
    double scale,
    double width,
    double height,
  ) {
    return Transform.scale(
      scale: scale,
      child: Container(
        height: height * 2,
        width: width * 2,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(200),
          ),
        ),
      ),
    );
  }

  Widget _QuadradoBaixo(
    Color color,
    double scale,
    double width,
    double height,
  ) {
    return Transform.scale(
      scale: scale,
      child: Container(
        height: height * 2,
        width: width * 2,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(200),
          ),
        ),
      ),
    );
  }
}
