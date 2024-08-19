part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {
  final LoginResponseModel response;

  LoginLoaded({required this.response});

  @override
  List<Object> get props => [response];
}

final class LoginError extends LoginState {
  final String message;

  LoginError({required this.message});

  @override
  List<Object> get props => [message];
}
