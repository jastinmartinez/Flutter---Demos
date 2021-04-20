import 'package:equatable/equatable.dart';

import '../../../data/model/truck.dart';

abstract class TruckState extends Equatable {
  @override
  List<Object> get props => [];
}

class Truckinitial extends TruckState {
  final List<Truck> truck;

  Truckinitial({
    this.truck,
  });
  @override
  List<Object> get props => [truck];
}

class TruckLoading extends TruckState {}

class TruckSuccess extends TruckState {}

class TruckListeUpdated extends TruckState {
  final List<Truck> trucks;

  TruckListeUpdated({
    this.trucks,
  });

  @override
  List<Object> get props => [trucks];
}

class TruckFailure extends TruckState {}
