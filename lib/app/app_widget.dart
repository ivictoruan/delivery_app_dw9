import 'package:flutter/material.dart';

import 'core/global/global_context.dart';
import 'core/provider/application_binding.dart';
import 'core/ui/theme/theme_config.dart';
import 'pages/auth/login/login_router.dart';
import 'pages/auth/register/register_router.dart';
import 'pages/home/home_router.dart';
import 'pages/order/order_completed_page.dart';
import 'pages/order/order_router.dart';
import 'pages/product_detail/product_detail_router.dart';
import 'pages/splash/splash_page.dart';

class AppWidget extends StatelessWidget {
  final _navKey = GlobalKey<NavigatorState>();

  AppWidget({super.key}) {
    GlobalContext.instance.navigatorKey =
        _navKey; // jogando _nav p/ global context
  }

  @override
  Widget build(BuildContext context) {
    return ApplicationBinding(
      child: MaterialApp(
        title: "Café com Frutas App",
        theme: ThemeConfig.theme,
        navigatorKey: _navKey,
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashPage(),
          '/home': (context) => HomeRouter.page,
          '/productDetail': (context) => ProductDetailRouter.page,
          '/auth/login': (context) => LoginRouter.page,
          '/auth/register': (context) => RegisterRouter.page,
          '/order': (context) => OrderRouter.page,
          '/order/completed': (context) => const OrderCompletedPage(),
        },
      ),
    );
  }
}
