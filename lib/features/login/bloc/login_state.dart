import 'package:flutter/material.dart';

@immutable
abstract class LoginState{
}
abstract class LoginActionState extends LoginState{
}
class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginFailureState extends LoginState {
  final String error;
  LoginFailureState({required this.error});
}
class LoginToSignupState extends LoginActionState{}