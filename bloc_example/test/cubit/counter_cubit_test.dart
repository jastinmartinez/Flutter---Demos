import 'package:bloc_example/Logic/cubit/counter_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'CounterCubit',
    () {
      CounterCubit counterCubit;
      setUp(
        () {
          //counterCubit = CounterCubit();
        },
      );

      tearDown(
        () {
          counterCubit.close();
        },
      );

      test(
        'the initial state for the CounterCubit is CounterState(counterValue:0)',
        () {
          expect(counterCubit.state, CounterState(counterValue: 0));
        },
      );

      blocTest(
        'Increment',
        build: () => counterCubit,
        act: (cubit) => cubit.increment(),
        expect: [CounterState(counterValue: 1, isIncremented: true)],
      );

      blocTest(
        'Decrement',
        build: () => counterCubit,
        act: (cubit) => cubit.decrement(),
        expect: [CounterState(counterValue: -1, isIncremented: false)],
      );
    },
  );
}
