import 'dart:async';

import 'package:food_app/data/FirebaseAccount.dart';
import 'package:food_app/features/login/bloc/login_event.dart';
import 'package:food_app/features/login/bloc/login_state.dart';
import 'package:bloc/bloc.dart';
import 'package:food_app/features/signup/bloc/signup_event.dart';
import 'package:food_app/features/signup/bloc/signup_state.dart';
class SignupBloc extends Bloc<SignupEvent,SignupState> {
  SignupBloc() :super(SignupInitialState()) {
    on<SignupButtonPressedEvent>(signupClickButtonLoginEvent);
    on<SignupToLoginEvent>(signupToLoginEvent);
  }
  FutureOr<void> signupClickButtonLoginEvent(
      SignupButtonPressedEvent event, Emitter<SignupState> emit) async{
      if(await FirebaseAccount.CheckAccount(event.username, event.password, event.email)==true)
        {
          emit(SignupSuccessState());
          FirebaseAccount.UpdateProfileUser(event.username, event.password, event.email);
        }
  }
  FutureOr<void> signupToLoginEvent(
      SignupToLoginEvent event, Emitter<SignupState> emit) {
    emit(SignupToLoginSate());
  }
}