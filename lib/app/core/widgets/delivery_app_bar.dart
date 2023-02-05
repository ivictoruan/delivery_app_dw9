import 'package:flutter/material.dart';

class DeliveryAppBar extends AppBar {
  DeliveryAppBar({Key? key})
      : super(
          key: key,
          elevation: 1,
          title: Image.asset(
            "assets/images/logo.png",
            width: 80,
          ),
        );
}
