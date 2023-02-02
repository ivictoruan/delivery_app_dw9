import 'package:delivery_app_dw9/app/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';


class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: "Café com Frutas App",
      routes: {
        '/': (context) => const SplashPage(),
      }
    );
  }
}