import 'package:flutter/material.dart';

@immutable
abstract class HomeEvent{
}
class HomeInitialEvent extends HomeEvent{}
class HomeToHomeEvent extends HomeEvent{}
class HomeToSearchEvent extends HomeEvent{}
class HomeToFavoriteEvent extends HomeEvent{}
class HomeToProfileEvent extends HomeEvent{}