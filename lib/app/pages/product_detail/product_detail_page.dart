import 'package:auto_size_text/auto_size_text.dart';
import 'package:delivery_app_dw9/app/core/extensions/formatter_extension.dart';
import 'package:delivery_app_dw9/app/core/ui/helpers/size_extensions.dart';
import 'package:delivery_app_dw9/app/core/ui/styles/text_styles.dart';
import 'package:delivery_app_dw9/app/core/ui/widgets/delivery_app_bar.dart';
import 'package:delivery_app_dw9/app/dto/order_product_dto.dart';
import 'package:delivery_app_dw9/app/pages/product_detail/product_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/ui/base_state/base_state.dart';
import '../../core/ui/widgets/increment_decrement_button_widget.dart';
import '../../models/product_model.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductModel product;
  final OrderProductDto? order;
  const ProductDetailPage({Key? key, required this.product, this.order})
      : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState
    extends BaseState<ProductDetailPage, ProductDetailController> {
  @override
  void initState() {
    super.initState();
    final amount = widget.order?.amount ?? 1;
    controller.initial(amount, widget.order != null);
  }

  void _showConfirmDelete(int amount) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text("Excluir o produto?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Cancelar",
                  style:
                      context.textStyles.textBold.copyWith(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();

                  Navigator.of(context).pop(
                      OrderProductDto(product: widget.product, amount: amount));
                },
                child: Text(
                  "Confirmar",
                  style: context.textStyles.textBold,
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: context.screenWidth,
            height: context.percentageHeight(0.4),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  widget.product.image,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              widget.product.name,
              style: context.textStyles.textExtraBold.copyWith(
                fontSize: 22,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  widget.product.description,
                  textAlign: TextAlign.justify,
                  style: context.textStyles.textLight.copyWith(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BlocBuilder<ProductDetailController, int>(
                builder: (context, amount) {
                  return SizedBox(
                    width: context.percentageWidth(0.4),
                    child: IncrementDecrementButtonWidget(
                      decrementOnTap: () => controller.decrement(),
                      incrementOnTap: () => controller.increment(),
                      amount: amount,
                    ),
                  );
                },
              ),
              SizedBox(
                height: 50,
                width: context.percentageWidth(0.5),
                child: BlocBuilder<ProductDetailController, int>(
                    builder: (context, amount) {
                  return ElevatedButton(
                    style: amount == 0
                        ? ElevatedButton.styleFrom(primary: Colors.red)
                        : null,
                    onPressed: () {
                      if (amount == 0) {
                        _showConfirmDelete(amount);
                      } else {
                        Navigator.of(context).pop(OrderProductDto(
                            product: widget.product, amount: amount));
                      }
                    },
                    child: Visibility(
                      visible: amount > 0,
                      replacement: Text(
                        "Excluir Produto",
                        style: context.textStyles.textExtraBold,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Adicionar",
                            // textAlign: TextAlign.start,
                            style: context.textStyles.textExtraBold.copyWith(
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: AutoSizeText(
                              (widget.product.price * amount).currencyPTBR,
                              maxFontSize: 13,
                              minFontSize: 5,
                              maxLines: 1,
                              style: context.textStyles.textExtraBold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
