import 'dart:developer';

import 'package:contact_name/model/contact_model.dart';
import 'package:contact_name/repository/contacts_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bloc/bloc.dart';
part 'contact_list_cubit_state.dart';
part 'contact_list_cubit.freezed.dart';

class ContactListCubit extends Cubit<ContactListCubitState> {
  final ContactsRepository _contactsRepository;
  ContactListCubit({required ContactsRepository contactsRepository})
      : _contactsRepository = contactsRepository,
        super(const ContactListCubitState.initial());

  Future<void> findAll() async {
    try {
      emit(const ContactListCubitState.loading());
      final contactsCubit = await _contactsRepository.findAll();
      await Future.delayed(const Duration(seconds: 4));

      print(contactsCubit);
      emit(ContactListCubitState.data(contacts: contactsCubit));
    } catch (e, s) {
      log('Erro ao  listar contacto ', error: e, stackTrace: s);
      emit(const ContactListCubitState.error(
          message: 'Erro ao listar Contatos'));
    }
  }
}
