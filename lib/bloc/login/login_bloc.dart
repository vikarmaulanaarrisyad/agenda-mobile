import 'package:agenda_mobile/data/datasources/api_datasources.dart';
import 'package:agenda_mobile/data/models/request/login_request_model.dart';
import 'package:agenda_mobile/data/models/response/login_response_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ApiDatasource datasource;

  LoginBloc(this.datasource) : super(LoginInitial()) {
    on<ProsesLoginEvent>((event, emit) async {
      emit(LoginLoading());
      try {
        final result = await datasource.login(event.request);
        emit(LoginLoaded(response: result));
      } catch (error) {
        emit(LoginError(message: error.toString()));
      }
    });
  }
}
