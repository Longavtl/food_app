import 'package:flutter/material.dart';

@immutable
abstract class SignupState{
}
class SignupInitialState extends SignupState {}

class SignupLoadingState extends SignupState {}

class SignupSuccessState extends SignupState {}
class SignupToLoginSate extends SignupState {}
class SignupFailureState extends SignupState {
  final String error;
  SignupFailureState({required this.error});
}