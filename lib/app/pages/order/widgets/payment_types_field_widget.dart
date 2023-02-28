import 'package:delivery_app_dw9/app/core/ui/helpers/size_extensions.dart';
import 'package:delivery_app_dw9/app/core/ui/styles/text_styles.dart';
import 'package:delivery_app_dw9/app/models/payment_type_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';

class PaymentTypesFieldWidget extends StatelessWidget {
  final List<PaymentTypeModel> paymentTypes;
  final ValueChanged<int> valueChanged;
  final bool valid;
  final String valueSelected;
  const PaymentTypesFieldWidget({
    super.key,
    required this.paymentTypes,
    required this.valueChanged,
    required this.valid,
    required this.valueSelected, // p/ quando rebuildar a tela
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Forma de Pagamento",
          style: context.textStyles.textRegular.copyWith(
            fontSize: 16,
          ),
        ),
        SmartSelect<String>.single(
          title: '',
          selectedValue: valueSelected,
          modalType: S2ModalType.bottomSheet,
          onChange: (selected) {
            valueChanged(int.parse(selected.value));
          },
          tileBuilder: (context, state) {
            return InkWell(
              onTap: state.showModal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: context.screenWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          state.selected.title ?? 'Toque para selecionar',
                          style: context.textStyles.textRegular,
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Color(0XFF00343F),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: !valid,
                    child: const Divider(
                      color: Colors.red,
                    ),
                  ),
                  Visibility(
                    visible: !valid,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "Selecione uma forma de pagamento!",
                        style: context.textStyles.textRegular.copyWith(
                          fontSize: 12,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          choiceItems: S2Choice.listFrom<String, Map<String, String>>(
            source: paymentTypes
                .map((paymentType) => {
                      'value': paymentType.id.toString(),
                      'title': paymentType.name
                    })
                .toList(),
            title: (index, item) => item['title'] ?? '',
            value: (index, item) => item['value'] ?? '',
            group: (index, item) => 'Selecione uma forma de pagamento',
          ),
          choiceType: S2ChoiceType.radios,
          choiceGrouped: true,
          modalFilter: false,
          placeholder: '',
        )
      ],
    );
  }
}
