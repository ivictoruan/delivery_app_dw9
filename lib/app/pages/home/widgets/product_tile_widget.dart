import 'package:delivery_app_dw9/app/core/extensions/formatter_extension.dart';
import 'package:delivery_app_dw9/app/core/ui/styles/colors_app.dart';
import 'package:delivery_app_dw9/app/core/ui/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/ui/widgets/show_product_image_widget.dart';
import '../../../dto/order_product_dto.dart';
import '../../../models/product_model.dart';
import '../home_controller.dart';

class ProductTileWidget extends StatelessWidget {
  final ProductModel product;
  final OrderProductDto? orderProduct;

  const ProductTileWidget({
    Key? key,
    required this.product,
    required this.orderProduct,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final String? productImage = product.image;
    return InkWell(
      onTap: () async {
        final controller = context.read<
            HomeController>(); // guardar o objeto antes de usar (Event Loop)
        final orderProductResult =
            await Navigator.of(context).pushNamed('/productDetail', arguments: {
          'product': product,
          'order': orderProduct,
        });

        if (orderProductResult != null) {
          controller.addOrUpdateBag(orderProductResult as OrderProductDto);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: context.textStyles.textExtraBold.copyWith(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    product.description,
                    style: context.textStyles.textRegular.copyWith(
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    product.price.currencyPTBR,
                    style: context.textStyles.textMedium.copyWith(
                      fontSize: 12,
                      color: context.colors.secondary,
                    ),
                  ),
                ],
              ),
            ),
            ShowProductImageWidget(urlImage: product.image),
          ],
        ),
      ),
    );
  }
}
