import 'dart:convert';
import 'package:agenda_mobile/data/models/request/agenda_request_model.dart';

class AgendaResponseModel {
  final int status;
  final String message;
  final List<AgendaModel> data;

  AgendaResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AgendaResponseModel.fromJson(String str) =>
      AgendaResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AgendaResponseModel.fromMap(Map<String, dynamic> map) =>
      AgendaResponseModel(
        status: map['status'],
        message: map['message'],
        data: List<AgendaModel>.from(
          map['data'].map((item) => AgendaModel.fromMap(item)),
        ),
      );

  Map<String, dynamic> toMap() => {
        'status': status,
        'message': message,
        'data': List<dynamic>.from(data.map((item) => item.toMap())),
      };
}
