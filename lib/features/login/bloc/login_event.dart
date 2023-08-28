import 'package:flutter/material.dart';

@immutable
abstract class LoginEvent{
}
class LoginButtonPressedEvent extends LoginEvent {
  final String username;
  final String password;
  LoginButtonPressedEvent({
    required this.username,
    required this.password,
  });
}
class LoginToSignupEvent extends LoginEvent{
}