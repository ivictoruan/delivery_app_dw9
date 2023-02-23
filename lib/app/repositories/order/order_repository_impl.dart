import 'dart:developer';

import 'package:delivery_app_dw9/app/core/exceptions/repository_exception.dart';
import 'package:delivery_app_dw9/app/dto/order_dto.dart';
import 'package:dio/dio.dart';

import '../../core/rest_client/custom_dio.dart';
import '../../models/payment_type_model.dart';
import 'order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final CustomDio dio;

  OrderRepositoryImpl({required this.dio});

  @override
  Future<List<PaymentTypeModel>> getAllPaymentsTypes() async {
    try {
      final result = await dio.auth().get("/payment-types");
      final allPaymentsTypes = result.data
          .map<PaymentTypeModel>(
              (paymentType) => PaymentTypeModel.fromMap(paymentType))
          .toList();
      return allPaymentsTypes;
    } on DioError catch (e, s) {
      const errorMessage = "Erro ao buscar formas de pagamento";
      log(errorMessage, error: e, stackTrace: s);
      throw RepositoryException(message: errorMessage);
    }
  }

  @override
  Future<void> saveOrder(OrderDto order) async {
    try {
      await dio.auth().post(
        "/orders",
        data: {
          'products': order.products
              .map((e) => {
                    'id': e.product.id,
                    'amoutn': e.amount,
                    'total_price': e.totalPrice,
                  })
              .toList(),
          'user_id': '#userAuthRef', // o id do user logado
          'address': order.address,
          'CPF': order.document,
          'payment_method_id': order.paymentMethod
        },
      );
    } on DioError catch (e, s) {
    const String  message = "Erro ao registrar pedido";
      log(message, error: e, stackTrace: s);
      throw RepositoryException(message: message);
    }
  }
}
