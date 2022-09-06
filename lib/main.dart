import 'package:contact_name/features/bloc_example/bloc/example_bloc.dart';
import 'package:contact_name/features/bloc_example/bloc_example.dart';
import 'package:contact_name/features/bloc_freezed/example_freezed_bloc.dart';
import 'package:contact_name/features/bloc_freezed_example.dart';
import 'package:contact_name/features/contact_cubit/list/contact_list_cubit_page.dart';
import 'package:contact_name/features/contact_cubit/list/cubit/contact_list_cubit.dart';
import 'package:contact_name/features/contact_cubit/register/contact_register_cubit.page.dart';
import 'package:contact_name/features/contact_cubit/register/cubit/contact_register_cubit.dart';
import 'package:contact_name/features/contacts_bloc/list/bloc/contact_list_bloc.dart';
import 'package:contact_name/features/contacts_bloc/list/contact_list_page.dart';
import 'package:contact_name/features/contacts_bloc/register/bloc/contact_register_bloc.dart';
import 'package:contact_name/features/contacts_bloc/register/contact_register_page.dart';
import 'package:contact_name/features/contacts_bloc/update/bloc/contact_update_bloc.dart';
import 'package:contact_name/features/contacts_bloc/update/contact_update_page.dart';
import 'package:contact_name/home/home_page.dart';
import 'package:contact_name/model/contact_model.dart';
import 'package:contact_name/repository/contacts_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ContactsRepository(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/bloc/example/': (_) => BlocProvider(
                create: (_) => ExampleBloc()..add(ExampleFindNameEvent()),
                child: const BlocExample(),
              ),
          '/bloc/example/freezed': (context) => BlocProvider(
                create: (context) =>
                    ExampleFreezedBloc()..add(ExampleFreezedEvent.findNames()),
                child: const BlocFreezedExample(),
              ),
          '/contacts/list': (context) => BlocProvider(
                create: (context) => ContactListBloc(
                    repository: context.read<ContactsRepository>())
                  ..add(const ContactListEvent.findAll()),
                child: const ContactListPage(),
              ),
          '/contacts/register': (context) => BlocProvider(
                create: (context) =>
                    ContactRegisterBloc(contactsRepository: context.read()),
                child: const ContactRegisterPage(),
              ),
          '/contacts/update': (context) {
            final contact =
                ModalRoute.of(context)!.settings.arguments as ContactModel;

            return BlocProvider(
              create: (context) => ContactUpdateBloc(
                contactsRepository: context.read(),
              ),
              child: ContactUpdatePage(
                model: contact,
              ),
            );
          },
          '/contacts/list/cubit': (context) {
            return BlocProvider(
              create: (context) =>
                  ContactListCubit(contactsRepository: context.read())
                    ..findAll(),
              child: const ContactListCubitPage(),
            );
          },
          '/contacts/register/cubit': (context) => BlocProvider(
                create: (context) => ContactRegisterCubit(
                    repository: context.read<ContactsRepository>()),
                child: const ContactRegisterCubitPage(),
              ),
        },
        home: const HomePage(),
      ),
    );
  }
}
