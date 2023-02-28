import 'package:delivery_app_dw9/app/repositories/order/order_repository.dart';
import 'package:delivery_app_dw9/app/repositories/order/order_repository_Impl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'order_controller.dart';
import 'order_page.dart';

class OrderRouter {
  OrderRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<OrderRepository>(
            create: (context) => OrderRepositoryImpl(
              dio: context.read(),
            ),
          ),
          Provider(
            create: (context) => OrderController(
              context.read(),
            ),
          ),
        ],
        child: const OrderPage(),
      );
}
