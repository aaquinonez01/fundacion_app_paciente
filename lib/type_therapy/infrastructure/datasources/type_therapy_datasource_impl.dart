import 'package:dio/dio.dart';
import 'package:fundacion_paciente_app/config/constants/enviroments.dart';
import 'package:fundacion_paciente_app/shared/infrastructure/services/key_value_storage_service_impl.dart';
import 'package:fundacion_paciente_app/type_therapy/domain/datasources/type_therapy_datasource.dart';
import 'package:fundacion_paciente_app/type_therapy/domain/entities/type_therapy_entity.dart';

class TypeTherapyDatasourceImpl implements TypeTherapyDatasource {
  final keyValueStorageService = KeyValueStorageServiceImpl();
  final dio = Dio(BaseOptions(
    baseUrl: Environment.apiUrl,
    headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer '},
  ));

  Future<String?> _getToken() async {
    final token = await keyValueStorageService.getValue<String>('token');
    print('token2: $token');
    return token;
  }

  Future<void> _setAuthorizationHeader() async {
    final token = await _getToken();
    print('token: $token');
    if (token != null && token.isNotEmpty) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }
  }

  @override
  Future<List<TypeTherapyEntity>> getTypeTherapies() async {
    await _setAuthorizationHeader();
    final response = await dio.get('/specialty-therapy');
    final typeTherapies = (response.data as List)
        .map((typeTherapy) => TypeTherapyEntity.fromJson(typeTherapy))
        .toList();
    return typeTherapies;
  }

  @override
  Future<TypeTherapyEntity> getTypeTherapyById(String id) {
    // TODO: implement getTypeTherapyById
    throw UnimplementedError();
  }
}
