import 'package:fundacion_paciente_app/home/domain/entities/patient_entities.dart';

class PatientMapper {
  static Patient patientJsonToEntity(Map<String, dynamic> json) {
    return Patient(
      id: json['id'] ?? '',
      firstname: json['firstname'] ?? '',
      lastname: json['lastname'] ?? '',
      allergies: (json['allergies'] as List<dynamic>?)
              ?.map((item) => item.toString())
              .toList() ??
          [], // ✅ Convertir a List<String>
      birthdate: json['birthdate'] ?? '',
      currentMedications: (json['currentMedications'] as List<dynamic>?)
              ?.map((item) => item.toString())
              .toList() ??
          [], // ✅ Convertir a List<String>
      disability: (json['disability'] as List<dynamic>?)
              ?.map((item) => item.toString())
              .toList() ??
          [], // ✅ Convertir a List<String>
      dni: json['dni'] ?? '',
      gender: json['gender'] ?? '',
      healthInsurance: json['healthInsurance'] ?? '',
      historyTreatmentsReceived:
          (json['historyTreatmentsReceived'] as List<dynamic>?)
                  ?.map((item) => item.toString())
                  .toList() ??
              [], // ✅ Convertir a List<String>
      legalGuardian: json['legalGuardian'] ?? '',
      legalGuardianId: json['legalGuardianId'] ?? '',
      observations: json['observations'] ?? '',
      relationshipRepresentativePatient:
          json['relationshipRepresentativePatient'] ?? '',
      typeTherapyRequired: json['typeTherapyRequired'] ?? '',
    );
  }
}
