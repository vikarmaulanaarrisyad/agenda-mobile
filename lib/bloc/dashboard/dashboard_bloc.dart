import 'package:agenda_mobile/data/datasources/api_datasources.dart';
import 'package:agenda_mobile/data/models/request/agenda_request_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final ApiDatasource datasource;
  final String token; // Add a token to be used for API requests

  DashboardBloc(this.datasource, this.token) : super(DashboardInitial()) {
    on<FetchAgendaEvent>((event, emit) async {
      emit(DashboardLoading());
      try {
        final response = await datasource.fetchAgendas(token);
        if (response.status == 200) {
          emit(DashboardLoaded(agendas: response.data));
        } else {
          emit(DashboardError(message: response.message));
        }
      } catch (error) {
        emit(DashboardError(message: error.toString()));
      }
    });
  }
}
