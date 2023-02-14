import 'package:delivery_app_dw9/app/core/ui/styles/text_styles.dart';
import 'package:delivery_app_dw9/app/core/ui/widgets/delivery_app_bar.dart';
import 'package:delivery_app_dw9/app/core/ui/widgets/delivery_button.dart';
import 'package:delivery_app_dw9/app/dto/order_product_dto.dart';
import 'package:delivery_app_dw9/app/models/product_model.dart';
import 'package:delivery_app_dw9/app/pages/order/widgets/order_product_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

import 'widgets/order_field_widget.dart';
import 'widgets/payment_types_field_widget.dart';

class OrderPage extends StatefulWidget {
  // final List<OrderProductDto> bag;

  const OrderPage({
    super.key,
  });

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppBar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    "Carrinho",
                    style: context.textStyles.textTitle.copyWith(
                      color: const Color(0XFF00343F),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset("assets/images/trashRegular.png"),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Column(
                  children: [
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: OrderProductTileWidget(
                        index: index,
                        orderProduct: OrderProductDto(
                          amount: 10,
                          product: ProductModel.fromMap({}),
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                );
              },
              childCount: 2,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total do Pedido",
                        style: context.textStyles.textExtraBold.copyWith(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        r"R$ 124,00",
                        style: context.textStyles.textExtraBold.copyWith(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  OrderFieldWidget(
                    titleField: "Endereço de Entrega",
                    controller: TextEditingController(),
                    hintText: "Digite um endereço",
                    validator: Validatorless.required("m"),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  OrderFieldWidget(
                    titleField: "CPF",
                    controller: TextEditingController(),
                    hintText: "Digite o CPF",
                    validator: Validatorless.required("m"),
                  ),
                  const PaymentTypesFieldWidget(),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: DeliveryButton(
                    width: double.infinity,
                    height: 48,
                    label: "FINALIZAR",
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
