import 'package:equatable/equatable.dart';
import '../../../data/model/user.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStarted extends AuthenticationEvent {}

class AuthenticationSignedUp extends AuthenticationEvent {
  final User user;
  AuthenticationSignedUp({this.user});
  @override
  List<Object> get props => [user];
}

class AuthenticationSignedIn extends AuthenticationEvent {
  final User user;
  AuthenticationSignedIn({this.user});
  @override
  List<Object> get props => [user];
}

class AuthenticationLoggedOut extends AuthenticationEvent {}

class AuthenticationAlreadySignedIn extends AuthenticationEvent {
  final User user;
  AuthenticationAlreadySignedIn({this.user});
  @override
  List<Object> get props => [user];
}
