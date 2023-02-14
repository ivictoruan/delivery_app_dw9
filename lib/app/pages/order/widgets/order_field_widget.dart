import 'package:delivery_app_dw9/app/core/ui/styles/text_styles.dart';
import 'package:flutter/material.dart';

class OrderFieldWidget extends StatelessWidget {
  final String titleField;
  final TextEditingController controller;
  final FormFieldValidator validator;
  final String hintText;
  const OrderFieldWidget({
    super.key,
    required this.titleField,
    required this.controller,
    required this.validator,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    const defaultBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titleField,
          style: context.textStyles.textRegular.copyWith(
            fontSize: 16,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(height: 2),
        TextFormField(
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            border: defaultBorder,
            enabledBorder: defaultBorder,
            focusedBorder: defaultBorder,
          ),
        ),
      ],
    );
  }
}
