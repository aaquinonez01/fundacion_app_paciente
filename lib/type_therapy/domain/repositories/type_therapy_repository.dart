import 'package:fundacion_paciente_app/type_therapy/domain/entities/type_therapy_entity.dart';

abstract class TypeTherapyRepository {
  Future<List<TypeTherapyEntity>> getTypeTherapies();
  Future<TypeTherapyEntity> getTypeTherapyById(String id);
}
