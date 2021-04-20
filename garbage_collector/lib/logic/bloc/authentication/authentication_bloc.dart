import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repository/authentication_repository.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final _authenticationRepository = AuthenticationRepository();

  StreamSubscription _userStreamSubscription;

  AuthenticationBloc() : super(AuthenticationInitial()) {
    monitorUserIsSignedIn();
  }

  void monitorUserIsSignedIn() {
    _userStreamSubscription = _authenticationRepository.user.listen(
      (user) {
        if (user.id.isNotEmpty) {
          this.add(AuthenticationAlreadySignedIn(user: user));
        }
      },
    );
  }

  @override
  Future<void> close() {
    _userStreamSubscription.cancel();
    return super.close();
  }

  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationAlreadySignedIn) {
      yield AuthenticationAuthenticated(
        user: event.user,
      );
    }
    if (event is AuthenticationSignedUp) {
      yield AuthenticationLoading();
      final _user = await _authenticationRepository.signUp(
        email: event.user.email,
        password: event.user.password,
      );
      yield AuthenticationAuthenticated(user: _user);
    }
    if (event is AuthenticationSignedIn) {
      yield AuthenticationLoading();
      final _user = await _authenticationRepository.signIn(
        email: event.user.email,
        password: event.user.password,
      );
      yield AuthenticationAuthenticated(user: _user);
    }
    if (event is AuthenticationLoggedOut) {
      _authenticationRepository.logOut();
      yield AuthenticationUnAuthenticated();
    }
  }
}
