part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardState extends Equatable {
  @override
  List<Object> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final List<AgendaModel> agendas;

  DashboardLoaded({required this.agendas});

  @override
  List<Object> get props => [agendas];
}

class DashboardError extends DashboardState {
  final String message;

  DashboardError({required this.message});

  @override
  List<Object> get props => [message];
}
