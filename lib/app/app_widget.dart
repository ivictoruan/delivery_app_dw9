import 'package:delivery_app_dw9/app/core/provider/application_binding.dart';
import 'package:flutter/material.dart';

import 'core/ui/theme/theme_config.dart';
import 'pages/home/home_router.dart';
import 'pages/splash/splash_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ApplicationBinding(
      child: MaterialApp(
        title: "Café com Frutas App",
        theme: ThemeConfig.theme,
        debugShowCheckedModeBanner: false, 
        routes: {
          '/': (context) => const SplashPage(),
          '/home': (context) => HomeRouter.page,
        },
      ),
    );
  }
}
