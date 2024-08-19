// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:agenda_mobile/data/datasources/api_datasources.dart';
import 'package:agenda_mobile/data/models/request/register_model.dart';
import 'package:agenda_mobile/data/models/response/register_response_model.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final ApiDatasource datasource;

  RegisterBloc(
    this.datasource,
  ) : super(RegisterInitial()) {
    on<SaveRegisterEvent>((event, emit) async {
      try {
        emit(RegisterLoading());
        final result = await datasource.register(event.request);
        print(result);
        emit(RegisterLoaded(model: result));
      } catch (e) {
        print('Error: $e');
        emit(RegisterFailure(error: e.toString()));
      }
    });
  }
}
