import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:contact_name/model/contact_model.dart';
import 'package:contact_name/repository/contacts_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'contact_list_event.dart';
part 'contact_list_state.dart';

part 'contact_list_bloc.freezed.dart';

class ContactListBloc extends Bloc<ContactListEvent, ContactListState> {
  final ContactsRepository _repository;
  ContactListBloc({required ContactsRepository repository})
      : _repository = repository,
        super(ContactListState.inital()) {
    on<_ContactListEventFindAll>(_findAll);
    on<_ContactListEventDeleteId>(_delete);
  }
  Future<void> _findAll(
      _ContactListEventFindAll event, Emitter<ContactListState> emit) async {
    try {
      emit(ContactListState.loading());
      await _repository.findId();

      final contacts = await _repository.findAll();

      emit(ContactListState.data(contacts: contacts));
    } catch (e, s) {
      log(
        'erro ao buscar contato',
        error: e,
        stackTrace: s,
      );
      emit(
        ContactListState.error(error: 'Erro ao buscar contato'),
      );
    }
  }

  Future<FutureOr<void>> _delete(
      _ContactListEventDeleteId event, Emitter<ContactListState> emit) async {
    final contact = ContactModel(
      id: event.id,
      name: event.name,
      email: event.email,
    );
    await _repository.delete(contact);
  }
}
