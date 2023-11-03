import 'package:flutter/material.dart';

@immutable
abstract class ChiTietState{
}
abstract class ChiTietActionState extends ChiTietState{
}
class ChiTietInitialState extends ChiTietState {
  int count = 0;
  ChiTietInitialState(this.count);
}
class IncreaseState extends ChiTietActionState{}
class DecreasState extends ChiTietActionState{}
class ChiTietToCartState extends ChiTietActionState{}