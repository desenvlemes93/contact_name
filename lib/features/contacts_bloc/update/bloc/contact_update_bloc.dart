import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:contact_name/model/contact_model.dart';
import 'package:contact_name/repository/contacts_repository.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_update_event.dart';
part 'contact_update_state.dart';

part 'contact_update_bloc.freezed.dart';

class ContactUpdateBloc extends Bloc<ContactUpdateEvent, ContactUpdateState> {
  final ContactsRepository _contactsRepository;
  ContactUpdateBloc({required ContactsRepository contactsRepository})
      : _contactsRepository = contactsRepository,
        super(const ContactUpdateState.inital()) {
    on<_Save>(_save);
  }

  Future<FutureOr<void>> _save(
      _Save event, Emitter<ContactUpdateState> emit) async {
    try {
      final contactModel = ContactModel(
        id: event.id,
        name: event.name,
        email: event.email,
      );
      emit(const ContactUpdateState.loading());
      await Future.delayed(const Duration(seconds: 3));
      await _contactsRepository.update(contactModel);
      emit(const ContactUpdateState.success());
    } catch (e, s) {
      log('Erro ao cadastrar usuario', error: s, stackTrace: s);
      emit(const ContactUpdateState.error(error: 'Erro ao cadastrar Usuario'));
    }
  }
}
