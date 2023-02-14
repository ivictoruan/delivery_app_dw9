import 'package:delivery_app_dw9/app/core/ui/styles/text_styles.dart';
import 'package:delivery_app_dw9/app/core/ui/widgets/delivery_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/ui/base_state/base_state.dart';
import '../../../core/ui/widgets/delivery_button.dart';
import 'register_controller.dart';
import 'register_state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends BaseState<RegisterPage, RegisterController> {
  final _formKey = GlobalKey<FormState>();

  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  var _showPassword = false;

  @override
  void dispose() {
    _nameEC.dispose();
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: BlocListener<RegisterController, RegisterState>(
            listener: (context, state) {
              state.status.matchAny(
                  any: () => hideLoader(),
                  register: () => showLoader(),
                  error: () {
                    hideLoader();
                    showError("Erro ao registrar usuário. Tente novamente!");
                  },
                  success: () {
                    hideLoader();
                    showSuccess("Cadastro realizado com sucesso!");
                    Navigator.of(context).pop();
                  }
                  );
            },
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Cadastro",
                    style: context.textStyles.textTitle,
                  ),
                  Text(
                    "Preencha os campos abaixo para criar o seu cadastro.",
                    style: context.textStyles.textMedium.copyWith(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _nameEC,
                    decoration: const InputDecoration(labelText: "Nome"),
                    validator: Validatorless.required("Nome"),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _emailEC,
                    decoration: const InputDecoration(labelText: "E-mail"),
                    validator: Validatorless.multiple([
                      Validatorless.required("E-mail obrigatório"),
                      Validatorless.email("E-mail inválido!"),
                    ]),
                  ),
                  const SizedBox(height: 20),
                  StatefulBuilder(
                    builder: (context, setState) => TextFormField(
                      obscureText: !_showPassword,
                      controller: _passwordEC,
                      decoration: InputDecoration(
                        labelText: "Senha",
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _showPassword = !_showPassword;
                            });
                          },
                          icon: Icon(
                            _showPassword
                                ? Icons.lock_open_rounded
                                : Icons.lock_outlined,
                          ),
                        ),
                      ),
                      validator: Validatorless.multiple(
                        [
                          Validatorless.required("Senha obrigatória"),
                          Validatorless.min(
                              6, "Senha deve conter ao menos 6 caracteries!"),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  StatefulBuilder(
                    builder: (context, setState) => TextFormField(
                      obscureText: !_showPassword,
                      decoration: InputDecoration(
                        labelText: "Confirma senha",
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _showPassword = !_showPassword;
                            });
                          },
                          icon: Icon(
                            _showPassword
                                ? Icons.lock_open_rounded
                                : Icons.lock_outlined,
                          ),
                        ),
                      ),
                      validator: Validatorless.multiple(
                        [
                          Validatorless.required("Confirma senha obrigatória"),
                          Validatorless.min(6,
                              "Confirma senha deve conter ao menos 6 caracteries!"),
                          Validatorless.compare(
                              _passwordEC, "As senhas estão diferentes!"),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: DeliveryButton(
                      width: double.infinity,
                      label: "Cadastrar",
                      onPressed: () {
                        final bool valid =
                            _formKey.currentState?.validate() ?? false;
                        if (valid) {
                          controller.register(
                            _nameEC.text,
                            _emailEC.text,
                            _passwordEC.text,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
