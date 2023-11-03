import 'package:flutter/material.dart';

@immutable
abstract class ChiTietEvent{
}
class IncreaseEvent extends ChiTietEvent{
}
class DecreaseEvent extends ChiTietEvent{
}
class ChiTietToCartEvent extends ChiTietEvent {
}