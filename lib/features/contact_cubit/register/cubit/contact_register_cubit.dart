import 'package:bloc/bloc.dart';
import 'package:contact_name/repository/contacts_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:contact_name/model/contact_model.dart';
part 'contact_register_state.dart';
part 'contact_register_cubit.freezed.dart';

class ContactRegisterCubit extends Cubit<ContactRegisterCubitState> {
  final ContactsRepository _repository;
  ContactRegisterCubit({
    required ContactsRepository repository,
  })  : _repository = repository,
        super(ContactRegisterCubitState.initial());

  Future<void> saveRegister(
      {int? id, required String nome, required String email}) async {
    final numeracao = await _repository.findId();
    emit(ContactRegisterCubitState.loading());
    if (numeracao != null) {
      final contacts = ContactModel(
        id: numeracao + 1,
        name: nome,
        email: email,
      );

      await _repository.create(contacts);
      emit(
        ContactRegisterCubitState.success(),
      );
    }
  }
}
