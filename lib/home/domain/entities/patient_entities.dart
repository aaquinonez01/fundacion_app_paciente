class Patient {
  String? id;
  String firstname;
  String lastname;
  String legalGuardianId;
  DateTime birthdate;
  String legalGuardian;
  String dni;
  List<String> disability;
  String gender;
  String relationshipRepresentativePatient;
  String healthInsurance;
  List<String> typeTherapyRequired;
  List<String> currentMedications;
  List<String> allergies;
  List<String> historyTreatmentsReceived;
  String? observations;

  Patient({
    this.id,
    required this.firstname,
    required this.lastname,
    required this.legalGuardianId,
    required this.birthdate,
    required this.legalGuardian,
    required this.dni,
    required this.disability,
    required this.gender,
    required this.relationshipRepresentativePatient,
    required this.healthInsurance,
    required this.typeTherapyRequired,
    required this.currentMedications,
    required this.allergies,
    required this.historyTreatmentsReceived,
    this.observations,
  });

  //toJson
  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'legalGuardianId': legalGuardianId,
      'birthdate': birthdate,
      'legalGuardian': legalGuardian,
      'dni': dni,
      'disability': disability,
      'gender': gender,
      'relationshipRepresentativePatient': relationshipRepresentativePatient,
      'healthInsurance': healthInsurance,
      'typeTherapyRequired': typeTherapyRequired,
      'currentMedications': currentMedications,
      'allergies': allergies,
      'historyTreatmentsReceived': historyTreatmentsReceived,
    };
  }
}
