import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

part 'example_event.dart';
part 'example_state.dart';

class ExampleBloc extends Bloc<ExampleEvent, ExampleState> {
  ExampleBloc() : super(ExampleStateInitial()) {
    on<ExampleFindNameEvent>(_findNames);
    on<ExampleRemoveNameEvent>(_removeNames);
    on<ExampleAddNameEvent>(_addName);
  }

  FutureOr<void> _addName(
      ExampleAddNameEvent event, Emitter<ExampleState> emit) {
    final stateAddBloc = state;

    if (stateAddBloc is ExampleStateData) {
      final stateNames = [...stateAddBloc.name];
      print(stateNames);
      stateNames.add(event.name);
      emit(ExampleStateData(name: stateNames));
    }
  }

  FutureOr<void> _removeNames(
    ExampleRemoveNameEvent event,
    Emitter<ExampleState> emit,
  ) {
    final stateBloc = state;
    if (stateBloc is ExampleStateData) {
      final names = [...stateBloc.name];
      names.retainWhere((element) => element != event.name);
      emit(ExampleStateData(name: names));
    }
  }

  FutureOr<void> _findNames(
      ExampleFindNameEvent event, Emitter<ExampleState> emit) async {
    await Future.delayed(Duration(seconds: 2));
    final names = [
      'Ricardo Lemes',
      'Flutter Bloc',
      'Academia do Flutter',
    ];

    emit(ExampleStateData(name: names));
  }
}
