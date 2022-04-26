part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState {}

class PhoneNumberSubmittedState extends AuthState {}

class AuthSuccessState extends AuthState {}

class AuthErrorState extends AuthState {
  final String error;
  const AuthErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

class UnAuthState extends AuthState {}
