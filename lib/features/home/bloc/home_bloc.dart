import 'dart:async';

import 'package:food_app/features/home/bloc/home_event.dart';
import 'package:food_app/features/home/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class HomeBloc extends Bloc<HomeEvent,HomeState> {
  HomeBloc() :super(HomeInitialState()) {
  on<HomeToSearchEvent>(homeToSearchEvent);
  on<HomeToFavoriteEvent>(homeToFavoriteEvent);
  on<HomeToProfileEvent>(homeToProfileEvent);
  on<HomeToHomeEvent>(homeToHomeEvent);
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
}