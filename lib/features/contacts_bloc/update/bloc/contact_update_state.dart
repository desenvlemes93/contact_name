part of 'contact_update_bloc.dart';

@freezed
class ContactUpdateState with _$ContactUpdateState {
  const factory ContactUpdateState.inital() = _Initial;
  const factory ContactUpdateState.success() = _Success;
  const factory ContactUpdateState.loading() = _Loading;
  const factory ContactUpdateState.error({required String error}) = _Error;
}
