import 'package:flutter/material.dart';

@immutable
abstract class HomeState{
}
abstract class HomeActionState extends HomeState{
}
class HomeInitialState extends HomeState {}
class HomeLoadingState extends HomeState {}
class HomeToHomeScreenState extends HomeActionState {}
class HomeToSearchScreenState extends HomeActionState {}
class HomeToFavoriteScreenState extends HomeActionState{}
class HomeToProfileScreenState extends HomeActionState{}