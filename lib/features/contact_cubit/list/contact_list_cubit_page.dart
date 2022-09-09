import 'package:contact_name/features/contact_cubit/list/cubit/contact_list_cubit.dart';
import 'package:contact_name/features/contact_cubit/update_cubit/cubit/contact_update_cubit.dart';
import 'package:contact_name/model/contact_model.dart';

import 'package:contact_name/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactListCubitPage extends StatelessWidget {
  const ContactListCubitPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact lista Cubit'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/contacts/register/cubit');
          context.read<ContactListCubit>().findAll();
        },
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () => context.read<ContactListCubit>().findAll(),
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              child: Column(
                children: [
                  Loader<ContactListCubit, ContactListCubitState>(
                    selector: (state) {
                      return state.maybeWhen(
                        loading: () => true,
                        orElse: () => false,
                      );
                    },
                  ),
                  BlocSelector<ContactListCubit, ContactListCubitState,
                      List<ContactModel>>(
                    selector: (state) {
                      return state.maybeWhen(
                          data: (contacts) => contacts,
                          orElse: () => <ContactModel>[]);
                    },
                    builder: (context, contacts) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: contacts.length,
                        itemBuilder: ((context, index) {
                          final contact = contacts[index];
                          return ListTile(
                            onLongPress: () async {
                              context
                                  .read<ContactListCubit>()
                                  .delete(model: contact);
                              context.read<ContactListCubit>().findAll();
                            },
                            onTap: () async {
                              await Navigator.pushNamed(
                                  context, '/contacts/update/cubit',
                                  arguments: contact);
                              context.read<ContactListCubit>().findAll();
                            },
                            title: Text(contact.name),
                            subtitle: Text(contact.email),
                          );
                        }),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
