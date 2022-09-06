import 'package:contact_name/features/contact_cubit/update_cubit/cubit/contact_update_cubit.dart';
import 'package:contact_name/model/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactUpdateCubitPage extends StatefulWidget {
  final ContactModel model;
  const ContactUpdateCubitPage({super.key, required this.model});

  @override
  State<ContactUpdateCubitPage> createState() => _ContactUpdateCubitPageState();
}

class _ContactUpdateCubitPageState extends State<ContactUpdateCubitPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nomeEC;
  late TextEditingController _emailEC;
  @override
  void initState() {
    _nomeEC = TextEditingController(text: widget.model.name);
    _emailEC = TextEditingController(text: widget.model.email);
    super.initState();
  }

  @override
  void dispose() {
    _emailEC.dispose();
    _nomeEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atualização do cadastro'),
      ),
      body: Form(
        key: _formKey,
        child: BlocListener<ContactUpdateCubit, ContactUpdateState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              TextFormField(
                controller: _nomeEC,
                decoration: const InputDecoration(
                  label: Text('Nome'),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Nome inválida';
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
                    return 'Nome inválida';
                  }
                  return null;
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
