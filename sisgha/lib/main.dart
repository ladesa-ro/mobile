import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sisgha/app/constants/theme_app.dart';
import 'package:sisgha/app/routes/app_routes.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
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
          900, // maxTabletWidth (opcional)
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
