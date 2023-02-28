import 'package:delivery_app_dw9/app/core/extensions/formatter_extension.dart';
import 'package:delivery_app_dw9/app/core/ui/styles/colors_app.dart';
import 'package:delivery_app_dw9/app/core/ui/styles/text_styles.dart';
import 'package:delivery_app_dw9/app/core/ui/widgets/increment_decrement_button_widget.dart';
import 'package:delivery_app_dw9/app/core/ui/widgets/show_product_image_widget.dart';
import 'package:delivery_app_dw9/app/pages/order/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final product = orderProduct.product;
    final controller = context.read<OrderController>();
    return Row(
      children: [
        ShowProductImageWidget(
          urlImage: product.image,
          width: 90,
          height: 90,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                style: context.textStyles.textMedium,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    (orderProduct.amount * product.price).currencyPTBR,
                    style: context.textStyles.textMedium.copyWith(
                      color: context.colors.secondary,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    width: 130,
                    child: IncrementDecrementButtonWidget.compact(
                      amount: orderProduct.amount,
                      incrementOnTap: () => controller.incrementProduct(index),
                      decrementOnTap: () => controller.decrementProduct(index),
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
