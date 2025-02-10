import 'dart:convert';

class Appointments {
  final String id;
  final String date;
  final String appointmentTime;
  final String medicalInsurance;
  final String status;
  final String diagnosis;
  final String doctorId;
  final String doctor;
  final String patient;
  final String emailPatient;
  final String specialtyTherapy;

  Appointments({
    required this.id,
    required this.date,
    required this.appointmentTime,
    required this.medicalInsurance,
    required this.status,
    required this.diagnosis,
    required this.doctorId,
    required this.doctor,
    required this.patient,
    required this.emailPatient,
    required this.specialtyTherapy,
  });

  /// 🔹 Convierte un JSON en un objeto `Appointments`
  factory Appointments.fromJson(Map<String, dynamic> json) {
    return Appointments(
      id: json['id'] ?? '',
      date: json['date'] ?? '',
      appointmentTime: json['appointmentTime'] ?? '',
      medicalInsurance: json['medicalInsurance'] ?? '',
      status: json['status'] ?? '',
      diagnosis: json['diagnosis'] ?? '',
      doctorId: json['doctorID'] ?? 'No asignado',
      doctor: json['doctor'] ?? 'No asignado',
      patient: json['patient'] ?? '',
      emailPatient: json['emailPatient'] ?? 'No hay correo registrado',
      specialtyTherapy: json['specialtyTherapy'] ?? '',
    );
  }

  /// 🔹 Convierte el objeto `Appointments` a JSON
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "date": date,
      "appointmentTime": appointmentTime,
      "medicalInsurance": medicalInsurance,
      "status": status,
      "diagnosis": diagnosis,
      "doctorID": doctorId,
      "doctor": doctor,
      "patient": patient,
      "emailPatient": emailPatient,
      "specialtyTherapy": specialtyTherapy,
    };
  }

  /// 🔹 Copia el objeto con nuevos valores (útil para actualizar el estado)
  Appointments copyWith({
    String? id,
    String? date,
    String? appointmentTime,
    String? medicalInsurance,
    String? status,
    String? diagnosis,
    String? doctorId,
    String? doctor,
    String? patient,
    String? emailPatient,
    String? specialtyTherapy,
  }) {
    return Appointments(
      id: id ?? this.id,
      date: date ?? this.date,
      appointmentTime: appointmentTime ?? this.appointmentTime,
      medicalInsurance: medicalInsurance ?? this.medicalInsurance,
      status: status ?? this.status,
      diagnosis: diagnosis ?? this.diagnosis,
      doctorId: doctorId ?? this.doctorId,
      doctor: doctor ?? this.doctor,
      patient: patient ?? this.patient,
      emailPatient: emailPatient ?? this.emailPatient,
      specialtyTherapy: specialtyTherapy ?? this.specialtyTherapy,
    );
  }

  /// 🔹 Convierte el objeto a JSON string
  String toJsonString() => json.encode(toJson());

  /// 🔹 Convierte un JSON string a `Appointments`
  factory Appointments.fromJsonString(String source) =>
      Appointments.fromJson(json.decode(source));

  @override
  String toString() {
    return 'Appointments(id: $id, date: $date, appointmentTime: $appointmentTime, '
        'medicalInsurance: $medicalInsurance, status: $status, '
        'diagnosis: $diagnosis, doctorId: $doctorId, doctor: $doctor, '
        'patient: $patient, emailPatient: $emailPatient, specialtyTherapy: $specialtyTherapy)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Appointments &&
        other.id == id &&
        other.date == date &&
        other.appointmentTime == appointmentTime &&
        other.medicalInsurance == medicalInsurance &&
        other.status == status &&
        other.diagnosis == diagnosis &&
        other.doctorId == doctorId &&
        other.doctor == doctor &&
        other.patient == patient &&
        other.emailPatient == emailPatient &&
        other.specialtyTherapy == specialtyTherapy;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        date.hashCode ^
        appointmentTime.hashCode ^
        medicalInsurance.hashCode ^
        status.hashCode ^
        diagnosis.hashCode ^
        doctorId.hashCode ^
        doctor.hashCode ^
        patient.hashCode ^
        emailPatient.hashCode ^
        specialtyTherapy.hashCode;
  }
}
