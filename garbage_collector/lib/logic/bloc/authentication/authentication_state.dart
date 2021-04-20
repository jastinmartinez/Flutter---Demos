import 'package:equatable/equatable.dart';
import 'package:garbage_collector/data/model/user.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  final User user;

  AuthenticationAuthenticated({this.user});
  @override
  List<Object> get props => [user];
}

class AuthenticationUnAuthenticated extends AuthenticationState {}
