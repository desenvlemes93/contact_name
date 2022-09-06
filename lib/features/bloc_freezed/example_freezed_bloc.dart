import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'example_freezed_state.dart';
part 'examle_freezed_event.dart';
part 'example_freezed_bloc.freezed.dart';

class ExampleFreezedBloc
    extends Bloc<ExampleFreezedEvent, ExampleFreezedState> {
  ExampleFreezedBloc() : super(ExampleFreezedState.initial()) {
    on<_ExampleFreezedEventFindNames>(_findNames);
    on<_ExampleFreezedEventAddName>(_addName);
    //  on<_ExampleFreezedEventRemoveNames>(_removeNames);
  }

  FutureOr<void> _addName(
      _ExampleFreezedEventAddName event, Emitter<ExampleFreezedState> emit) {
    final names = state.maybeWhen(
      data: (names) => names,
      orElse: () => const <String>[],
    );
    final newNames = [...names];
    newNames.add(event.name);
    emit(ExampleFreezedState.data(names: newNames));

    emit(ExampleFreezedState.showBanner(
        names: newNames, message: 'NOme sendo inserido!!!'));
  }
}

FutureOr<void> _findNames(_ExampleFreezedEventFindNames event,
    Emitter<ExampleFreezedState> emit) async {
  emit(ExampleFreezedState.loading());
  await Future.delayed(
    const Duration(seconds: 4),
  );
  final names = [
    'Ricardo Lemes',
    'Flutter Bloc',
    'Academia do Flutter',
  ];

  emit(ExampleFreezedState.data(names: names));
}
