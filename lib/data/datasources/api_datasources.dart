import 'package:agenda_mobile/data/models/request/login_request_model.dart';
import 'package:agenda_mobile/data/models/request/register_model.dart';
import 'package:agenda_mobile/data/models/response/agenda_response_model.dart';
import 'package:agenda_mobile/data/models/response/login_response_model.dart';
import 'package:agenda_mobile/data/models/response/register_response_model.dart';
import 'package:http/http.dart' as http;

class ApiDatasource {
  Future<RegisterResponseModel> register(RegisterModel registerModel) async {
    final response = await http.post(
      Uri.parse('http://192.168.0.102/agenda/public/api/register'),
      // headers: {'Content-Type': 'application/json'},
      body: registerModel.toMap(),
    );

    final result = RegisterResponseModel.fromJson(response.body);
    return result;
  }

  Future<LoginResponseModel> login(LoginRequestModel LoginRequestModel) async {
    final response = await http.post(
      // Uri.parse('http://192.168.0.102/agenda/public/api/login'),
      Uri.parse('http://192.168.1.10/agenda/public/api/login'),
      // headers: {'Content-Type': 'application/json'},
      body: LoginRequestModel.toMap(),
    );

    if (response.statusCode == 200) {
      return LoginResponseModel.fromJson(response.body);
    } else {
      throw Exception('Failed to login: ${response.reasonPhrase}');
    }
  }

  Future<AgendaResponseModel> fetchAgendas(String token) async {
    final response = await http.get(
      // Uri.parse('http://192.168.0.102/agenda/public/api/agenda'),
      Uri.parse('http://192.168.1.10/agenda/public/api/agenda'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return AgendaResponseModel.fromJson(response.body);
    } else {
      throw Exception('Failed to fetch agendas: ${response.reasonPhrase}');
    }
  }
}
