import 'package:flutter/material.dart';

import '../styles/app_styles.dart';

class DeliveryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;

  const DeliveryButton(
      {Key? key,
      required this.label,
      this.onPressed,
      this.width,
      this.height = 50})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: AppStyles.instance.primaryButton,
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
