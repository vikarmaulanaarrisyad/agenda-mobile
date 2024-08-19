part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchAgendaEvent extends DashboardEvent {}
