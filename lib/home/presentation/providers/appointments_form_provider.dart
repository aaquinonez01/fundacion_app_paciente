import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fundacion_paciente_app/auth/presentation/providers/auth_provider.dart';

import 'package:fundacion_paciente_app/home/domain/entities/patient_entities.dart';
import 'package:fundacion_paciente_app/home/domain/repositories/appointment_repository.dart';
import 'package:fundacion_paciente_app/home/domain/repositories/patient_repository.dart';
import 'package:fundacion_paciente_app/home/infrastructure/repositories/appointment_repository_impl.dart';
import 'package:fundacion_paciente_app/home/infrastructure/repositories/patient_repository_impl.dart';
import 'package:fundacion_paciente_app/type_therapy/domain/repositories/type_therapy_repository.dart';
import 'package:fundacion_paciente_app/type_therapy/infrastructure/repositories/type_therapy_repository_impl.dart';

// 🔹 Provider del formulario de citas
final appointmentFormProvider = StateNotifierProvider.autoDispose<
    AppointmentFormNotifier, AppointmentFormState>(
  (ref) {
    final appointmentRepo = AppointmentRepositoryImpl();
    final patientRepo = PatientRepositoryImpl();
    final typeTherapyRepo = TypeTherapyRepositoryImpl();
    return AppointmentFormNotifier(
        appointmentRepository: appointmentRepo,
        patientRepository: patientRepo,
        typeTherapyRepository: typeTherapyRepo);
  },
);

// 🔹 Notifier que maneja el estado del formulario de citas
class AppointmentFormNotifier extends StateNotifier<AppointmentFormState> {
  final AppointmentRepository appointmentRepository;
  final PatientRepository patientRepository;
  final TypeTherapyRepository typeTherapyRepository;
  final String nombre_representante;

  AppointmentFormNotifier(
      {required this.appointmentRepository,
      required this.nombre_representante,
      required this.patientRepository,
      required this.typeTherapyRepository})
      : super(AppointmentFormState()) {
    getTypeTherapics(); // ✅ Cargar áreas terapéuticas al iniciar
  }

  // 🔹 Cambiar paciente manualmente
  void onPatientChanged(String value) {
    state = state.copyWith(patientId: value);
  }

  void onCedulaChanged(String value) {
    state = state.copyWith(cedula: value);
  }

  Future<void> getTypeTherapics() async {
    try {
      print('🔹 Cargando áreas terapéuticas...');
      final areas = await typeTherapyRepository.getTypeTherapies();
      state = state.copyWith(areas: areas);
      print('🔹 Áreas terapéuticas cargadas: ${areas.length}');
    } catch (e) {
      state = state.copyWith(
          loading: false, errorMessage: 'Error al obtener áreas terapéuticas');
    }
  }

  // 🔹 Buscar paciente por DNI
  Future<void> getPacienteByDni(String dni) async {
    try {
      print('🔹 Buscando paciente por DNI: $dni');
      state = state.copyWith(loading: true);
      final paciente = await patientRepository.getPatientByDni(dni);
      state = state.copyWith(
        loading: false,
        patientId: paciente.id,
        patientEntity: paciente,
      );
      print('🔹 Paciente: ${state.patientEntity?.firstname} ');
    } catch (e) {
      state = state.copyWith(
          loading: false, errorMessage: 'Error al obtener paciente');
    }
  }

  // 🔹 Cambiar diagnóstico
  void onDiagnosisChanged(String value) {
    state = state.copyWith(diagnosis: value);
  }

  // 🔹 Seleccionar Área
  void onAreaChanged(String value) {
    state = state.copyWith(specialtyTherapyId: value);
  }

  // 🔹 Seleccionar Fecha
  void onDateChanged(DateTime value) {
    state = state.copyWith(selectedDate: value);
  }

  // 🔹 Seleccionar Hora
  void onTimeChanged(String value) {
    state = state.copyWith(selectedTime: value);
  }

  // 🔹 Guardar Cita
  Future<void> saveAppointment() async {
    if (state.specialtyTherapyId == null ||
        state.selectedDate == null ||
        state.selectedTime == null ||
        state.patientId.isEmpty ||
        state.diagnosis.isEmpty) {
      state = state.copyWith(errorMessage: 'Todos los campos son obligatorios');
      return;
    }

    try {
      state = state.copyWith(loading: true);

      final newAppointment = Appointments(
        date: state.selectedDate!.toIso8601String(),
        appointmentTime: state.selectedTime!,
        medicalInsurance: state.patientEntity?.healthInsurance ?? 'No seguro',
        diagnosis: state.diagnosis,
        patient: state.patientId,
        specialtyTherapy: state.specialtyTherapyId!,
      );

      await appointmentRepository.createAppointment(newAppointment);
      state = state.copyWith(loading: false);
      print('✅ Cita guardada correctamente');
    } catch (e) {
      state =
          state.copyWith(loading: false, errorMessage: 'Error al guardar cita');
    }
  }
}

// 📌 Estado del formulario de citas
class AppointmentFormState {
  final String cedula;
  final String patientId;
  final Patient? patientEntity;
  final String diagnosis;
  final List<TypeTherapyEntity> areas;
  final String? specialtyTherapyId;
  final DateTime? selectedDate;
  final String? selectedTime;
  final bool loading;
  final String errorMessage;

  const AppointmentFormState({
    this.cedula = '',
    this.patientId = '',
    this.patientEntity,
    this.diagnosis = '',
    this.areas = const [],
    this.specialtyTherapyId,
    this.selectedDate,
    this.selectedTime,
    this.loading = false,
    this.errorMessage = '',
  });

  AppointmentFormState copyWith({
    String? cedula,
    String? patientId,
    Patient? patientEntity,
    String? diagnosis,
    List<TypeTherapyEntity>? areas,
    String? specialtyTherapyId,
    DateTime? selectedDate,
    String? selectedTime,
    bool? loading,
    String? errorMessage,
  }) {
    return AppointmentFormState(
      cedula: cedula ?? this.cedula,
      patientId: patientId ?? this.patientId,
      patientEntity: patientEntity ?? this.patientEntity,
      diagnosis: diagnosis ?? this.diagnosis,
      areas: areas ?? this.areas,
      specialtyTherapyId: specialtyTherapyId ?? this.specialtyTherapyId,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
      loading: loading ?? this.loading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
