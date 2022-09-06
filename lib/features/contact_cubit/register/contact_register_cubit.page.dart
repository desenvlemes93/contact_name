import 'package:contact_name/features/contact_cubit/register/cubit/contact_register_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactRegisterCubitPage extends StatefulWidget {
  const ContactRegisterCubitPage({
    super.key,
  });

  @override
  State<ContactRegisterCubitPage> createState() =>
      _ContactRegisterCubitPageState();
}

class _ContactRegisterCubitPageState extends State<ContactRegisterCubitPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeEC = TextEditingController();
  final _emailEC = TextEditingController();

  @override
  void dispose() {
    _nomeEC.dispose();
    _emailEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro Registro no Cubit'),
      ),
      body: Form(
        key: _formKey,
        child: BlocListener<ContactRegisterCubit, ContactRegisterCubitState>(
          listenWhen: (previous, current) {
            return current.maybeWhen(
              success: () => true,
              error: (_) => true,
              orElse: () => false,
            );
          },
          listener: (_, state) {
            state.whenOrNull(
              success: () => Navigator.of(context).pop(),
              error: (error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(
                      error,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Nome'),
                  ),
                  controller: _nomeEC,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Nome é Obrigatório';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('E-mail'),
                  ),
                  controller: _emailEC,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'E-mail é Obrigatório';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                      onPressed: () {
                        final _formValid =
                            _formKey.currentState?.validate() ?? false;

                        if (_formValid) {
                          context.read<ContactRegisterCubit>()
                            ..saveRegister(
                              id: 0,
                              nome: _nomeEC.text,
                              email: _emailEC.text,
                            );
                        }
                      },
                      icon: const Icon(Icons.save),
                      label: const Text('Salvar')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
