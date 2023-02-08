import 'package:delivery_app_dw9/app/core/ui/styles/text_styles.dart';
import 'package:delivery_app_dw9/app/core/ui/widgets/delivery_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../core/ui/widgets/delivery_button.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Cadastro",
                  style: context.textStyles.textTitle,
                ),
                // const SizedBox(height: 30),
                Text(
                  "Preencha os campos abaixo para criar o seu cadastro.",
                  style: context.textStyles.textMedium.copyWith(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Nome"),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Email"),
                ),
                const SizedBox(height: 30),

                TextFormField(
                  decoration: const InputDecoration(labelText: "Senha"),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: "Confirma senha"),
                ),
                const SizedBox(height: 30),
                Center(
                  child: DeliveryButton(
                    width: double.infinity,
                    label: "Cadastrar",
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
