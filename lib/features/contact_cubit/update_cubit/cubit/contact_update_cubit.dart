import 'package:contact_name/model/contact_model.dart';
import 'package:contact_name/repository/contacts_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'contact_update_state.dart';
part 'contact_update_cubit.freezed.dart';

class ContactUpdateCubit extends Cubit<ContactUpdateState> {
  final ContactsRepository _repository;
  ContactUpdateCubit({required ContactsRepository repository})
      : _repository = repository,
        super(const ContactUpdateState.initial());

  Future<void> updateCadastro({
    required int id,
    required String name,
    required String email,
  }) async {
    emit(const ContactUpdateState.loading());
    final contactModel = ContactModel(
      id: id,
      name: name,
      email: email,
    );

    await Future.delayed(const Duration(seconds: 4));
    await _repository.update(contactModel);
    emit(const ContactUpdateState.success());
  }
}
