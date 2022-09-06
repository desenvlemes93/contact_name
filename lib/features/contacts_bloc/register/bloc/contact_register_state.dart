part of 'contact_register_bloc.dart';

@freezed
class ContactRegisterState with _$ContactRegisterState {
  const factory ContactRegisterState.inital() = _Initial;
  const factory ContactRegisterState.loading() = _Loading;
  const factory ContactRegisterState.sucess() = _Success;
  const factory ContactRegisterState.error({required String error}) = _Error;
}
