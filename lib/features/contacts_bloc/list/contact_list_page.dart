import 'package:contact_name/features/contacts_bloc/list/bloc/contact_list_bloc.dart';
import 'package:contact_name/model/contact_model.dart';
import 'package:contact_name/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactListPage extends StatelessWidget {
  const ContactListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact List Bloc'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).pushNamed('/contacts/register');
          context.read<ContactListBloc>().add(ContactListEvent.findAll());
        },
        child: const Icon(Icons.add),
      ),
      body: BlocListener<ContactListBloc, ContactListState>(
        listenWhen: (previous, current) {
          return current.maybeWhen(
            error: (error) => true,
            orElse: () => false,
          );
        },
        listener: (context, state) {
          state.whenOrNull(
            error: (error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    error,
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: RefreshIndicator(
          onRefresh: () async => context.read<ContactListBloc>()
            ..add(const ContactListEvent.findAll()),
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                child: Column(
                  children: [
                    Loader<ContactListBloc, ContactListState>(
                      selector: (state) {
                        return state.maybeWhen(
                          loading: () => true,
                          orElse: () => false,
                        );
                      },
                    ),
                    BlocSelector<ContactListBloc, ContactListState,
                        List<ContactModel>>(selector: (state) {
                      return state.maybeWhen(
                        data: (contacts) => contacts,
                        orElse: () => [],
                      );
                    }, builder: (context, conctats) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: conctats.length,
                        itemBuilder: ((context, index) {
                          final contact = conctats[index];
                          return BlocSelector<ContactListBloc, ContactListState,
                              bool>(
                            selector: (state) {
                              return state.maybeWhen(
                                delete: () => true,
                                orElse: () => false,
                              );
                            },
                            builder: (context, state) {
                              return Dismissible(
                                background: Container(
                                  color: Colors.red,
                                ),
                                direction: DismissDirection.endToStart,
                                key: const ValueKey(5),
                                onDismissed: (direction) {
                                  context.read<ContactListBloc>()
                                    ..add(
                                      ContactListEvent.deleteId(
                                        id: contact.id,
                                        name: contact.name,
                                        email: contact.email,
                                      ),
                                    );
                                },
                                child: ListTile(
                                  onTap: () async {
                                    await Navigator.pushNamed(
                                        context, '/contacts/update',
                                        arguments: contact);
                                    context.read<ContactListBloc>()
                                      ..add(ContactListEvent.findAll());
                                  },
                                  title: Text(contact.name),
                                  subtitle: Text(contact.email),
                                ),
                              );
                            },
                          );
                        }),
                      );
                    }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
