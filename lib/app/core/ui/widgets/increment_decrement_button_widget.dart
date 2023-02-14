import 'package:delivery_app_dw9/app/core/ui/styles/colors_app.dart';
import 'package:delivery_app_dw9/app/core/ui/styles/text_styles.dart';
import 'package:flutter/material.dart';

class IncrementDecrementButtonWidget extends StatelessWidget {
  final int amount;
  final VoidCallback incrementOnTap;
  final VoidCallback decrementOnTap;
  final bool _compact;

  const IncrementDecrementButtonWidget(
      {super.key,
      required this.amount,
      required this.incrementOnTap,
      required this.decrementOnTap})
      : _compact = false;

  const IncrementDecrementButtonWidget.compact(
      {super.key,
      required this.amount,
      required this.incrementOnTap,
      required this.decrementOnTap})
      : _compact = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _compact ? 90 : 159,
      height: _compact ? 40 : 49,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: Colors.grey)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: decrementOnTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
              child: Text(
                "-",
                style: context.textStyles.textMedium.copyWith(
                  color: context.colors.secondary,
                  fontSize: _compact ? 10 : 22,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              amount.toString(),
              style: context.textStyles.textRegular.copyWith(
                color: context.colors.secondary,
                fontSize: _compact ? 13 : 17,
              ),
            ),
          ),
          InkWell(
            onTap: incrementOnTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
              child: Text(
                "+",
                style: context.textStyles.textMedium.copyWith(
                  color: context.colors.secondary,
                  fontSize: _compact ? 10 : 22,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
