import 'package:delivery_app_dw9/app/core/extensions/formatter_extension.dart';
import 'package:delivery_app_dw9/app/core/ui/helpers/size_extensions.dart';
import 'package:delivery_app_dw9/app/core/ui/styles/colors_app.dart';
import 'package:delivery_app_dw9/app/core/ui/styles/text_styles.dart';
import 'package:delivery_app_dw9/app/dto/order_product_dto.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShoppingBagWidget extends StatelessWidget {
  final List<OrderProductDto> bag;

  const ShoppingBagWidget({super.key, required this.bag});

  Future<void> _goOrder(BuildContext context) async {
    final navigator = Navigator.of(context);
    final sp = await SharedPreferences.getInstance();
    if (!sp.containsKey("accessToken")) {
      final loginResult = await navigator.pushNamed("/auth/login");
      bool notLogged = loginResult == null || loginResult == false;
      if (notLogged) {
        return; // [premature return]
      }
    }
    await navigator.pushNamed("/order", arguments: bag);
  }

  @override
  Widget build(BuildContext context) {
    final totalBag = bag.fold<double>(0.0,
        (totalValue, orderProduct) => totalValue += orderProduct.totalPrice);
    return Container(
      width: context.screenWidth,
      height: 90,
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
        child: InkWell(
          onTap: () => _goOrder(context),
          child: Container(
            width: 343,
            height: 48,
            decoration: BoxDecoration(
              color: context.colors.primary,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
                      totalBag.currencyPTBR,
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
        ),
      ),
    );
  }
}
