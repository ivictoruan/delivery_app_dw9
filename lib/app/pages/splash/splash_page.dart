import 'package:delivery_app_dw9/app/core/ui/helpers/size_extensions.dart';
import 'package:delivery_app_dw9/app/core/ui/widgets/delivery_button.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String startLogoPath = "assets/images/logo.png";
    String startHamburgerPath = "assets/images/lanche.png";
    return Scaffold(
      body: ColoredBox(
        color: const Color(0XFF140E0E),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: context.screenWidth,
                child: Image.asset(
                  startHamburgerPath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: context.percentageHeight(0.2),
                  ),
                  Image.asset(
                    startLogoPath,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: context.percentageHeight(0.1),
                  ),
                  DeliveryButton(
                    label: "ACESSAR",
                    width: context.percentageWidth(.6),
                    height: 40,
                    onPressed: () =>
                        Navigator.of(context).popAndPushNamed("/home"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
