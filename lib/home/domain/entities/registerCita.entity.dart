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
}
