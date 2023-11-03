import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/features/chitiet_food/bloc/chitiet_event.dart';
import 'package:food_app/features/chitiet_food/bloc/chitiet_state.dart';
class ChiTietBloc extends Bloc<ChiTietEvent,ChiTietState> {
  int count=0;
  ChiTietBloc() :super(ChiTietInitialState(0)) {
    on<IncreaseEvent>(increaseState);
  }
  FutureOr<void> increaseState(IncreaseEvent event, Emitter<ChiTietState> emit) {
    count++;
    emit(ChiTietInitialState(count));
    print(count);
  }
}