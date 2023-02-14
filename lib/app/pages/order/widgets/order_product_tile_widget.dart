import 'package:delivery_app_dw9/app/core/ui/styles/colors_app.dart';
import 'package:delivery_app_dw9/app/core/ui/styles/text_styles.dart';
import 'package:delivery_app_dw9/app/core/ui/widgets/increment_decrement_button_widget.dart';
import 'package:flutter/material.dart';

import '../../../dto/order_product_dto.dart';

class OrderProductTileWidget extends StatelessWidget {
  final int index;
  final OrderProductDto orderProduct;
  const OrderProductTileWidget({
    super.key,
    required this.index,
    required this.orderProduct,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            color: Colors.grey[200],
          ),
          child: Image.asset(
            "assets/images/lanche.png",
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "X- Burger",
                style: context.textStyles.textMedium,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    r"R$ 19,80",
                    style: context.textStyles.textMedium.copyWith(
                      color: context.colors.secondary,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    width: 130,
                    // height: 35,
                    child: IncrementDecrementButtonWidget.compact(
                      amount: 1,
                      incrementOnTap: () {},
                      decrementOnTap: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
