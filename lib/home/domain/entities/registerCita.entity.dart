class CreateAppointments {
  String patientId;
  DateTime date;
  String appointmentTime;
  String medicalInsurance;
  String specialtyTherapyId;
  String diagnosis;

  CreateAppointments({
    required this.patientId,
    required this.date,
    required this.appointmentTime,
    required this.medicalInsurance,
    required this.specialtyTherapyId,
    required this.diagnosis,
  });

  CreateAppointments copyWith({
    String? patientId,
    DateTime? date,
    String? appointmentTime,
    String? medicalInsurance,
    String? specialtyTherapyId,
    String? diagnosis,
  }) {
    return CreateAppointments(
      patientId: patientId ?? this.patientId,
      date: date ?? this.date,
      appointmentTime: appointmentTime ?? this.appointmentTime,
      medicalInsurance: medicalInsurance ?? this.medicalInsurance,
      specialtyTherapyId: specialtyTherapyId ?? this.specialtyTherapyId,
      diagnosis: diagnosis ?? this.diagnosis,
    );
  }

  //ToJson
  Map<String, dynamic> toJson() {
    return {
      'patientId': patientId,
      'date':
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
      'appointmentTime': appointmentTime,
      'medicalInsurance': medicalInsurance,
      'specialtyTherapyId': specialtyTherapyId,
      'diagnosis': diagnosis,
    };
  }

  //FromJson
  factory CreateAppointments.fromJson(Map<String, dynamic> json) {
    return CreateAppointments(
      patientId: json['patientId'],
      date: DateTime.parse(json['date']),
      appointmentTime: json['appointmentTime'],
      medicalInsurance: json['medicalInsurance'],
      specialtyTherapyId: json['specialtyTherapyId'],
      diagnosis: json['diagnosis'],
    );
  }
}
