import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_example/constants/enums.dart';
import 'package:bloc_example/logic/cubit/internet_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  final InternetCubit internetCubit;
  StreamSubscription internetStreamSubscription;

  CounterCubit({@required this.internetCubit})
      : super(CounterState(counterValue: 0)) {
    monitorInternetCubit();
  }

  StreamSubscription<InternetState> monitorInternetCubit() {
    return internetStreamSubscription = internetCubit.listen(
      (event) {
        if (event is InternetConnected &&
            event.connectionType == ConnectionType.Wifi)
          increment();
        else if (event is InternetConnected &&
            event.connectionType == ConnectionType.Mobile) decrement();
      },
    );
  }

  void increment() => emit(
      CounterState(counterValue: state.counterValue + 1, isIncremented: true));

  void decrement() => emit(
      CounterState(counterValue: state.counterValue - 1, isIncremented: false));

  @override
  Future<void> close() {
    internetStreamSubscription.cancel();
    return super.close();
  }
}
