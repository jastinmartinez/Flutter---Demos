import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:bloc_example/constants/enums.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  StreamSubscription connectivityStreamSubscription;

  InternetCubit({@required this.connectivity}) : super(InternetLoading()) {
    monitorInternetConnectivity();
  }

  StreamSubscription<ConnectivityResult> monitorInternetConnectivity() {
    return connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen(
      (event) {
        if (event == ConnectivityResult.wifi) {
          emitInternetConnected(ConnectionType.Wifi);
        } else if (event == ConnectivityResult.mobile) {
          emitInternetConnected(ConnectionType.Mobile);
        } else if (event == ConnectivityResult.none) {
          emiInternetDisconnected();
        }
      },
    );
  }

  void emitInternetConnected(ConnectionType connectionType) =>
      emit(InternetConnected(connectionType: connectionType));

  void emiInternetDisconnected() => emit(InternetDisconnected());

  @override
  Future<void> close() {
    connectivityStreamSubscription.cancel();
    return super.close();
  }
}
