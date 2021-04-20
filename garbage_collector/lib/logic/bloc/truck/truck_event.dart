import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../data/model/truck.dart';

abstract class TruckEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class TruckeListUpdated extends TruckEvent {
  final List<Truck> trucks;
  TruckeListUpdated({
    @required this.trucks,
  });
  @override
  List<Object> get props => [trucks];
}

class TruckeSaved extends TruckEvent {
  final Truck truck;
  TruckeSaved({
    @required this.truck,
  });
  @override
  List<Object> get props => [truck];
}
