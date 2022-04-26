part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class ChangeThemeLightState extends HomeState {}

class ChangeThemeDarkState extends HomeState {}
