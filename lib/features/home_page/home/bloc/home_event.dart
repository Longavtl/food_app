import 'package:flutter/material.dart';
import 'package:food_app/data/model/new_food.dart';

@immutable
abstract class HomeEvent{
}
class HomeInitialEvent extends HomeEvent{}
class HomeToHomeEvent extends HomeEvent{}
class HomeToSearchEvent extends HomeEvent{}
class HomeToFavoriteEvent extends HomeEvent{}
class HomeToProfileEvent extends HomeEvent{}
class HomeToChiTietEvent extends HomeEvent{
  final NewFood food ;
  HomeToChiTietEvent(this.food);
}