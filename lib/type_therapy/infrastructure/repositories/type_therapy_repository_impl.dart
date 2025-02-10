import 'package:fundacion_paciente_app/type_therapy/domain/datasources/type_therapy_datasource.dart';
import 'package:fundacion_paciente_app/type_therapy/domain/entities/type_therapy_entity.dart';
import 'package:fundacion_paciente_app/type_therapy/domain/repositories/type_therapy_repository.dart';
import 'package:fundacion_paciente_app/type_therapy/infrastructure/datasources/type_therapy_datasource_impl.dart';

class TypeTherapyRepositoryImpl implements TypeTherapyRepository {
  final TypeTherapyDatasource datasource;

  TypeTherapyRepositoryImpl({TypeTherapyDatasource? datasource})
      : datasource = datasource ?? TypeTherapyDatasourceImpl();

  @override
  Future<List<TypeTherapyEntity>> getTypeTherapies() {
    return datasource.getTypeTherapies();
  }

  @override
  Future<TypeTherapyEntity> getTypeTherapyById(String id) {
    return datasource.getTypeTherapyById(id);
  }
}
