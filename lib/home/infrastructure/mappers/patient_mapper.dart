import 'package:fundacion_paciente_app/home/domain/entities/patient_entities.dart';

class PatientMapper {
  static Patient patientJsonToEntity(Map<String, dynamic> json) {
    return Patient(
      id: json['id'] ?? '',
      firstname: json['firstname'] ?? '',
      lastname: json['lastname'] ?? '',
      allergies: json['allergies'] ?? '',
      birthdate: json['birthdate'] ?? '',
      currentMedications: json['currentMedications'] ?? '',
      disability: json['disability'] ?? '',
      dni: json['dni'] ?? '',
      gender: json['gender'] ?? '',
      healthInsurance: json['healthInsurance'] ?? '',
      historyTreatmentsReceived: json['historyTreatmentsReceived'] ?? '',
      legalGuardian: json['legalGuardian'] ?? '',
      legalGuardianId: json['legalGuardianId'] ?? '',
      observations: json['observations'] ?? '',
      relationshipRepresentativePatient:
          json['relationshipRepresentativePatient'] ?? '',
      typeTherapyRequired: json['typeTherapyRequired'] ?? '',
    );
  }
}
