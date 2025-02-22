import 'package:dartz/dartz.dart';

abstract class AuthState {}

class AuthInitiateState extends AuthState {}

class AuthStateLoading extends AuthState {}

class AuthResponseState extends AuthState {
  // var xx = '10';
  Either<String, String> response;
  AuthResponseState(this.response);
}
