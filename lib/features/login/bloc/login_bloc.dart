import 'dart:async';

import 'package:food_app/data/FirebaseAccount.dart';
import 'package:food_app/features/login/bloc/login_event.dart';
import 'package:food_app/features/login/bloc/login_state.dart';
import 'package:bloc/bloc.dart';
class LoginBloc extends Bloc<LoginEvent,LoginState> {
  LoginBloc() :super(LoginInitialState()) {
    on<LoginButtonPressedEvent>(loginClickButtonLoginEvent);
    on<LoginToSignupEvent>(loginToSignupEvent);
  }
  FutureOr<void> loginClickButtonLoginEvent(
      LoginButtonPressedEvent event, Emitter<LoginState> emit) async{
    emit(LoginLoadingState());
    try {
      if (await FirebaseAccount.CheckLogin(event.username, event.password)==true) {
          emit(LoginSuccessState());
      } else {
          emit(LoginFailureState(error: 'Sai Tài khoản hoặc mật khẩu'));
      }
    } catch (e) {
      emit(LoginFailureState(error: 'Lỗi'));
    }
  }
  FutureOr<void> loginToSignupEvent(
      LoginToSignupEvent event, Emitter<LoginState> emit) {
      emit(LoginToSignupState());
  }
}