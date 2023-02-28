import 'package:delivery_app_dw9/app/core/extensions/formatter_extension.dart';
import 'package:delivery_app_dw9/app/core/ui/styles/text_styles.dart';
import 'package:delivery_app_dw9/app/core/ui/widgets/delivery_app_bar.dart';
import 'package:delivery_app_dw9/app/core/ui/widgets/delivery_button.dart';
import 'package:delivery_app_dw9/app/dto/order_product_dto.dart';
import 'package:delivery_app_dw9/app/models/payment_type_model.dart';
import 'package:delivery_app_dw9/app/pages/order/widgets/order_product_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

import '../../core/ui/base_state/base_state.dart';
import 'order_controller.dart';
import 'widgets/order_field_widget.dart';
import 'widgets/order_state.dart';
import 'widgets/payment_types_field_widget.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({
    super.key,
  });

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends BaseState<OrderPage, OrderController> {
  final formKey = GlobalKey<FormState>();
  final addressEC = TextEditingController();
  final cpfEC = TextEditingController();

  int? paymentTypeId;
  final paymentTypeValid = ValueNotifier<bool>(true);

  @override
  void onReady() {
    final products =
        ModalRoute.of(context)!.settings.arguments as List<OrderProductDto>;
    controller.load(products);
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> _onWillPop() async {
      Navigator.of(context).pop(controller.state.orderProducts);
      return false;
    }

    void _showConfirmProductDialog(OrderConfirmDeleteProductState state) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title:
                Text("Excluir o produto ${state.orderProduct.product.name}?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  controller.cancelDeleteProcess();
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
                  controller.decrementProduct(state.index);

                  // Navigator.of(context).pop(
                  //     OrderProductDto(product: widget.product, amount: amount));
                },
                child: Text(
                  "Confirmar",
                  style: context.textStyles.textBold,
                ),
              ),
            ],
          );
        },
      );
    }

    return BlocListener<OrderController, OrderState>(
      listener: (context, state) {
        state.status.matchAny(
            any: hideLoader,
            loading: showLoader,
            error: () {
              hideLoader();
              showError(state.errorMessage ?? "Erro não informado!");
            },
            confirmRemoveProduct: () {
              hideLoader();
              if (state is OrderConfirmDeleteProductState) {
                _showConfirmProductDialog(state);
              }
            },
            emptyBag: () {
              showInfo(
                "Sua sacola está vazia, por favor selecione um produto!",
              );
              Navigator.pop(context, <OrderProductDto>[]);
            },
            success: () {
              hideLoader();
              Navigator.of(context).popAndPushNamed(
                "/order/completed",
                result: <OrderProductDto>[],
              );
            });
      },
      child: WillPopScope(
        // p/ navegar com navigator
        onWillPop: _onWillPop,
        child: Scaffold(
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
                        onPressed: () => controller.clearBag(),
                        icon: Image.asset("assets/images/trashRegular.png"),
                      ),
                    ],
                  ),
                ),
              ),
              BlocSelector<OrderController, OrderState, List<OrderProductDto>>(
                selector: (state) => state.orderProducts,
                builder: (context, orderProducts) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final orderProduct = orderProducts[index];
                        return Column(
                          children: [
                            const SizedBox(height: 4),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: OrderProductTileWidget(
                                index: index,
                                orderProduct: orderProduct,
                              ),
                            ),
                            const Divider(),
                          ],
                        );
                      },
                      childCount: orderProducts.length,
                    ),
                  );
                },
              ),
              Form(
                key: formKey,
                child: SliverToBoxAdapter(
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
                            BlocSelector<OrderController, OrderState, double>(
                              selector: (state) => state.totalValueOrder,
                              builder: (context, totalValueOrder) {
                                return Text(
                                  totalValueOrder.currencyPTBR,
                                  style:
                                      context.textStyles.textExtraBold.copyWith(
                                    fontSize: 20,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        const Divider(),
                        OrderFieldWidget(
                          titleField: "Endereço de Entrega",
                          controller: addressEC,
                          hintText: "Digite um endereço",
                          validator: Validatorless.multiple(
                            [
                              Validatorless.required("Endereço obrigatório!"),
                              Validatorless.min(15,
                                  "Coloque uma descrição melhor no endereço!")
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        OrderFieldWidget(
                          titleField: "CPF",
                          controller: cpfEC,
                          hintText: "Digite o CPF",
                          keyboardType: TextInputType.number,
                          validator: Validatorless.multiple([
                            Validatorless.required("CPF obrigatório!"),
                            Validatorless.cpf("Este CPF não é válido!"),
                          ]),
                        ),
                        BlocSelector<OrderController, OrderState,
                            List<PaymentTypeModel>>(
                          selector: (state) => state.paymentTypes,
                          builder: (context, paymentTypes) {
                            return ValueListenableBuilder(
                              valueListenable: paymentTypeValid,
                              builder:
                                  (context, bool paymentTypeValidValue, child) {
                                return PaymentTypesFieldWidget(
                                  paymentTypes: paymentTypes,
                                  valueChanged: (selected) =>
                                      paymentTypeId = selected,
                                  valid: paymentTypeValidValue,
                                  valueSelected: paymentTypeId.toString(),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
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
                        onPressed: () {
                          bool paymentTypeSelected = paymentTypeId != null;
                          paymentTypeValid.value = paymentTypeSelected;
                          final valid =
                              (formKey.currentState?.validate() ?? false) &&
                                  paymentTypeSelected;

                          if (valid) {
                            controller.saveOrder(
                              address: addressEC.text,
                              document: cpfEC.text,
                              paymentMethodID: paymentTypeId!,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
