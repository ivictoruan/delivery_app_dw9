import 'package:delivery_app_dw9/app/core/extensions/formatter_extension.dart';
import 'package:delivery_app_dw9/app/core/ui/styles/colors_app.dart';
import 'package:delivery_app_dw9/app/core/ui/styles/text_styles.dart';
import 'package:flutter/material.dart';

import '../../../models/product_model.dart';

class ProductTileWidget extends StatelessWidget {
  final ProductModel product;

  const ProductTileWidget({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          FadeInImage.assetNetwork(
            image: product.image,
            placeholder: "assets/images/loading.gif",
            width: 100,
            height: 100,
          ),
        ],
      ),
    );
  }
}
