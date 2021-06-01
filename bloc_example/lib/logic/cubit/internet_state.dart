part of 'internet_cubit.dart';

abstract class InternetState extends Equatable {
  const InternetState();

  @override
  List<Object> get props => [];
}

class InternetLoading extends InternetState {}

class InternetInitial extends InternetState {
  final ConnectionType connectionType;
  InternetInitial({@required this.connectionType});
}

class InternetConnected extends InternetState {
  final ConnectionType connectionType;
  InternetConnected({@required this.connectionType});
}

class InternetDisconnected extends InternetState {}
