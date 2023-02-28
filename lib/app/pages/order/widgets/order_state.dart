// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import 'package:delivery_app_dw9/app/dto/order_product_dto.dart';
import 'package:delivery_app_dw9/app/models/payment_type_model.dart';

part 'order_state.g.dart';

@match
enum OrderStatus {
  initial,
  loading,
  loaded,
  updateOrder,
  error,
  confirmRemoveProduct,
  emptyBag,
  success,
}

class OrderState extends Equatable {
  final OrderStatus status;
  final List<OrderProductDto> orderProducts;
  final List<PaymentTypeModel> paymentTypes;
  final String? errorMessage;

  const OrderState(
    this.errorMessage, {
    required this.status,
    required this.orderProducts,
    required this.paymentTypes,
  });

  const OrderState.initial()
      : status = OrderStatus.initial,
        orderProducts = const [],
        paymentTypes = const [],
        errorMessage = null;

  double get totalValueOrder {
    return orderProducts.fold(
        0.0, (previousValue, element) => previousValue + element.totalPrice);
  }

  @override
  List<Object> get props => [status, orderProducts, paymentTypes];

  OrderState copyWith({
    OrderStatus? status,
    List<OrderProductDto>? orderProducts,
    List<PaymentTypeModel>? paymentTypes,
    String? errorMessage,
  }) {
    return OrderState(
      status: status ?? this.status,
      orderProducts: orderProducts ?? this.orderProducts,
      paymentTypes: paymentTypes ?? this.paymentTypes,
      errorMessage ?? this.errorMessage,
    );
  }
}

class OrderConfirmDeleteProductState extends OrderState {
  final OrderProductDto orderProduct;
  final int index;

  const OrderConfirmDeleteProductState(
    super.errorMessage, {
    required this.orderProduct,
    required this.index,
    required super.status,
    required super.orderProducts,
    required super.paymentTypes,
  });
}
