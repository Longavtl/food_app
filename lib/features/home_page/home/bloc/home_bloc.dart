import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/features/home_page/home/bloc/home_event.dart';
import 'package:food_app/features/home_page/home/bloc/home_state.dart';
class HomeBloc extends Bloc<HomeEvent,HomeState> {
  HomeBloc() :super(HomeInitialState()) {
  on<HomeToSearchEvent>(homeToSearchEvent);
  on<HomeToFavoriteEvent>(homeToFavoriteEvent);
  on<HomeToProfileEvent>(homeToProfileEvent);
  on<HomeToHomeEvent>(homeToHomeEvent);
  on<HomeInitialEvent>(homeInitialEvent);
  on<HomeToChiTietEvent>(homeToChiTietEvent);
  }
  FutureOr<void> homeToSearchEvent(
      HomeToSearchEvent event, Emitter<HomeState> emit) {
    emit(HomeToSearchScreenState());
  }
  FutureOr<void> homeToFavoriteEvent(
      HomeToFavoriteEvent event, Emitter<HomeState> emit) {
    emit(HomeToFavoriteScreenState());
  }
  FutureOr<void> homeToProfileEvent(
      HomeToProfileEvent event, Emitter<HomeState> emit) {
    emit(HomeToProfileScreenState());
  }
  FutureOr<void> homeToHomeEvent(
      HomeToHomeEvent event, Emitter<HomeState> emit) {
    emit(HomeToHomeScreenState());
  }
  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(Duration(seconds: 2));
    emit(HomeLoadedSuccessState());
    print('xong');
  }

  FutureOr<void> homeToChiTietEvent(
      HomeToChiTietEvent event, Emitter<HomeState> emit) {
      emit(HomeToChiTietScreenState());
    print('2');
  }
}
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);
}

