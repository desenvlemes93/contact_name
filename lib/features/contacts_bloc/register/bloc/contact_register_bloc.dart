import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:contact_name/model/contact_model.dart';
import 'package:contact_name/repository/contacts_repository.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
part 'contact_register_state.dart';
part 'contact_register_event.dart';
part 'contact_register_bloc.freezed.dart';

class ContactRegisterBloc
    extends Bloc<ContactRegisterEvent, ContactRegisterState> {
  final ContactsRepository _contactsRepository;

  ContactRegisterBloc({required ContactsRepository contactsRepository})
      : _contactsRepository = contactsRepository,
        super(const ContactRegisterState.inital()) {
    on<_Save>(_save);
  }

  Future<FutureOr<void>> _save(
      event, Emitter<ContactRegisterState> emit) async {
    try {
      final incrementNumero = await _contactsRepository.findId();
      final contactModel = ContactModel(
        id: incrementNumero + 1,
        name: event.name,
        email: event.email,
      );
      emit(const ContactRegisterState.loading());
      await Future.delayed(const Duration(seconds: 3));
      await _contactsRepository.create(contactModel);
      emit(const ContactRegisterState.sucess());
    } catch (e, s) {
      log('Erro ao cadastrar usuario', error: s, stackTrace: s);
      emit(
          const ContactRegisterState.error(error: 'Erro ao cadastrar Usuario'));
    }
  }
}
