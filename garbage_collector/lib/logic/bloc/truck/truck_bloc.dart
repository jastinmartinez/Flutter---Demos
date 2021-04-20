import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repository/truck_repositoty.dart';
import 'truck_event.dart';
import 'truck_state.dart';

class TruckBloc extends Bloc<TruckEvent, TruckState> {
  TruckBloc() : super(Truckinitial(truck: [])) {
    _monitorNewTrucksAdded();
  }
  final _truckRepository = TruckRepository();

  void _monitorNewTrucksAdded() {
    _truckRepository.getAll().listen(
      (trucks) {
        this.add(
          TruckeListUpdated(trucks: trucks),
        );
      },
    );
  }

  @override
  Stream<TruckState> mapEventToState(TruckEvent event) async* {
    if (event is TruckeSaved) if (event is TruckeSaved) {
      yield TruckLoading();
      await _truckRepository.add(event.truck);
      yield TruckSuccess();
    }
    if (event is TruckeListUpdated) {
      yield TruckListeUpdated(trucks: event.trucks);
    }
  }
}
