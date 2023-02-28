import 'package:delivery_app_dw9/app/core/ui/helpers/size_extensions.dart';
import 'package:delivery_app_dw9/app/core/ui/styles/text_styles.dart';
import 'package:delivery_app_dw9/app/core/ui/widgets/delivery_button.dart';
import 'package:flutter/material.dart';

class OrderCompletedPage extends StatelessWidget {
  const OrderCompletedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: context.percentageHeight(0.2),
              ),
              Image.asset(
                "assets/images/logo_rounded.png",
                errorBuilder: (_, __, ___) {
                  return const Icon(Icons.error);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Pedido realizado com sucesso!\n Em breve você receberá a confirmação do seu pedido!!!",
                textAlign: TextAlign.center,
                style: context.textStyles.textExtraBold.copyWith(
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: context.percentageHeight(0.1),
              ),
              DeliveryButton(
                label: "Fechar!",
                width: context.percentageWidth(0.8),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
