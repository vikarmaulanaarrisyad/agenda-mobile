part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class ProsesLoginEvent extends LoginEvent {
  final LoginRequestModel request;

  ProsesLoginEvent({
    required this.request,
  });
}
