import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'order_controller.dart';
import 'order_page.dart';

class OrderRouter {
  OrderRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider(
            create: (context) => OrderController(),
            // builder: (context, child) {
            //   final args = ModalRoute.of(context)!.settings.arguments
            //       as List<OrderProductDto>;
            //   return OrderPage(
            //     bag: args["bag"]
            //   );
            // },
          ),
        ],
        child: const OrderPage(),
      );
}
