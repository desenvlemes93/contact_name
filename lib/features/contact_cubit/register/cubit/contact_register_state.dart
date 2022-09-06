part of 'contact_register_cubit.dart';

@freezed
class ContactRegisterCubitState with _$ContactRegisterCubitState {
  factory ContactRegisterCubitState.initial() = _Initial;
  factory ContactRegisterCubitState.data(
      {required List<ContactModel> contacts}) = _ContactRegisterStateData;
  factory ContactRegisterCubitState.loading() = _RegisterLoading;
  factory ContactRegisterCubitState.error({
    required String error,
  }) = _Error;
  factory ContactRegisterCubitState.success() = _Sucess;
}
