import 'package:delivery_app_dw9/app/core/extensions/formatter_extension.dart';
import 'package:delivery_app_dw9/app/core/ui/helpers/size_extensions.dart';
import 'package:delivery_app_dw9/app/core/ui/styles/text_styles.dart';
import 'package:delivery_app_dw9/app/dto/order_product_dto.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home_controller.dart';

class ShoppingBagWidget extends StatelessWidget {
  final List<OrderProductDto> bag;

  const ShoppingBagWidget({super.key, required this.bag});

  @override
  Widget build(BuildContext context) {
    final totalBag = bag
        .fold<double>(0.0,
            (totalValue, orderProduct) => totalValue + orderProduct.totalPrice)
        .currencyPTBR;

    return Container(
      width: context.screenWidth,
      height: 90,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Center(
        child: ElevatedButton(
          onPressed: () => _goToOrder(context),
          child: Stack(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Ver sacola",
                  style: context.textStyles.textExtraBold.copyWith(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  totalBag,
                  style: context.textStyles.textExtraBold.copyWith(
                    fontSize: 11,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _goToOrder(BuildContext context) async {
    final navigator = Navigator.of(context);
    final controller = context.read<HomeController>();
    final sp = await SharedPreferences.getInstance();

    if (!sp.containsKey("accessToken")) {
      final loginResult = await navigator.pushNamed("/auth/login");
      bool notLogged = loginResult == null || loginResult == false;
      if (notLogged) {
        return; // [premature return]
      }
    }
    // envio para order
    final updatedBag = await navigator
        .pushNamed("/order", arguments: bag);

    controller.updateBag((updatedBag ?? const <OrderProductDto>[]) as List<OrderProductDto>);
  }
}
