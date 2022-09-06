import 'package:contact_name/features/contacts_bloc/update/bloc/contact_update_bloc.dart';
import 'package:contact_name/model/contact_model.dart';
import 'package:contact_name/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactUpdatePage extends StatefulWidget {
  final ContactModel model;
  const ContactUpdatePage({
    super.key,
    required this.model,
  });

  @override
  State<ContactUpdatePage> createState() => _ContactUpdatePageState();
}

class _ContactUpdatePageState extends State<ContactUpdatePage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nomeEC;
  late final TextEditingController _emailEC;

  @override
  void initState() {
    super.initState();
    _nomeEC = TextEditingController(text: widget.model.name);
    _emailEC = TextEditingController(text: widget.model.email);
  }

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
        title: const Text(''),
      ),
      body: Form(
          key: _formKey,
          child: BlocListener<ContactUpdateBloc, ContactUpdateState>(
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
                    controller: _nomeEC,
                    decoration: const InputDecoration(
                      label: Text('Nome'),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Nome é obrigatório';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _emailEC,
                    decoration: const InputDecoration(
                      label: Text('E-mail'),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'E-mail é obrigatório';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final formValid =
                            _formKey.currentState?.validate() ?? false;

                        if (formValid) {
                          context
                              .read<ContactUpdateBloc>()
                              .add(ContactUpdateEvent.save(
                                id: widget.model.id!,
                                name: _nomeEC.text,
                                email: _emailEC.text,
                              ));
                        }
                      },
                      child: const Text('Salvar'),
                    ),
                  ),
                  Loader<ContactUpdateBloc, ContactUpdateState>(
                    selector: (state) {
                      return state.maybeWhen(
                        loading: () => true,
                        orElse: () => false,
                      );
                    },
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
