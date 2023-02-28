import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:delivery_app_dw9/app/dto/order_dto.dart';
import 'package:delivery_app_dw9/app/dto/order_product_dto.dart';

import '../../repositories/order/order_repository.dart';
import 'widgets/order_state.dart';

class OrderController extends Cubit<OrderState> {
  final OrderRepository _orderRepository;

  OrderController(this._orderRepository) : super(const OrderState.initial());

  Future<void> load(List<OrderProductDto> products) async {
    // esta função não fere o princípio da responsabilidade única?
    emit(state.copyWith(status: OrderStatus.loading));
    try {
      final paymentTypes = await _orderRepository.getAllPaymentsTypes();
      emit(state.copyWith(
          orderProducts: products,
          status: OrderStatus.loaded,
          paymentTypes: paymentTypes));
    } catch (e, s) {
      const msgLoadedError = "Erro ao carregar página!";
      log(msgLoadedError, error: e, stackTrace: s);
      emit(
        state.copyWith(
          status: OrderStatus.error,
          errorMessage: msgLoadedError,
        ),
      );
    }
  }

  void incrementProduct(int index) {
    final orders = [...state.orderProducts];
    final order = orders[index];
    if (order.amount < 9) {
      orders[index] = order.copyWith(amount: order.amount + 1);

      emit(
        state.copyWith(
          orderProducts: orders,
          status: OrderStatus.updateOrder,
        ),
      );
    }
  }

  void decrementProduct(int index) {
    final orders = [...state.orderProducts];
    final order = orders[index]; // pega a order que está na lista.
    final amount = order.amount;
    if (amount == 1) {
      if (state.status != OrderStatus.confirmRemoveProduct) {
        emit(
          OrderConfirmDeleteProductState(
            state.errorMessage,
            orderProduct: order,
            index: index,
            status: OrderStatus.confirmRemoveProduct,
            orderProducts: state.orderProducts,
            paymentTypes: state.paymentTypes,
          ),
        );

        return;
      } else {
        orders.removeAt(index);
      }
    } else {
      orders[index] = order.copyWith(amount: order.amount - 1);
    }

    if (orders.isEmpty) {
      emit(state.copyWith(status: OrderStatus.emptyBag));

      return;
    }
    emit(state.copyWith(
      orderProducts: orders,
      status: OrderStatus.updateOrder,
    ));
  }

  void cancelDeleteProcess() {
    emit(
      state.copyWith(
        status: OrderStatus.loaded,
      ),
    );
  }

  void clearBag() {
    emit(state.copyWith(status: OrderStatus.emptyBag));
  }

  void saveOrder(
      {required String address,
      required String document,
      required int paymentMethodID}) async {
    final order = OrderDto(
      products: state.orderProducts,
      address: address,
      document: document,
      paymentMethod: paymentMethodID,
    );
    emit(state.copyWith(status: OrderStatus.loading));
    await _orderRepository.saveOrder(order);
    emit(state.copyWith(status: OrderStatus.success));

  }
}
