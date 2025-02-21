import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fundacion_paciente_app/auth/infrastructure/errors/auth_errors.dart';
import 'package:fundacion_paciente_app/auth/presentation/providers/auth_provider.dart';
import 'package:fundacion_paciente_app/home/domain/entities/patient_entities.dart';
import 'package:fundacion_paciente_app/home/domain/entities/registerCita.entity.dart';
import 'package:fundacion_paciente_app/home/domain/repositories/appointment_repository.dart';
import 'package:fundacion_paciente_app/home/domain/repositories/patient_repository.dart';
import 'package:fundacion_paciente_app/home/infrastructure/repositories/appointment_repository_impl.dart';
import 'package:fundacion_paciente_app/home/infrastructure/repositories/patient_repository_impl.dart';
import 'package:fundacion_paciente_app/home/presentation/providers/appointments_provider.dart';
import 'package:fundacion_paciente_app/type_therapy/domain/entities/type_therapy_entity.dart';
import 'package:fundacion_paciente_app/type_therapy/domain/repositories/type_therapy_repository.dart';
import 'package:fundacion_paciente_app/type_therapy/infrastructure/repositories/type_therapy_repository_impl.dart';

// 🔹 Provider del formulario de citas
final appointmentFormProvider = StateNotifierProvider.autoDispose<
    AppointmentFormNotifier, AppointmentFormState>(
  (ref) {
    final appointmentRepo = AppointmentRepositoryImpl();
    final patientRepo = PatientRepositoryImpl();
    final registerAppointmentCallback =
        ref.watch(appointmentProvider.notifier).createAppointment;
    final typeTherapyRepo = TypeTherapyRepositoryImpl();
    final authState = ref.watch(authProvider);
    return AppointmentFormNotifier(
        appointmentRepository: appointmentRepo,
        patientRepository: patientRepo,
        registerAppointmentCallback: registerAppointmentCallback,
        typeTherapyRepository: typeTherapyRepo,
        patientId: authState.user!.patientID);
  },
);

// 🔹 Notifier que maneja el estado del formulario de citas
class AppointmentFormNotifier extends StateNotifier<AppointmentFormState> {
  final Function(CreateAppointments) registerAppointmentCallback;
  final AppointmentRepository appointmentRepository;
  final PatientRepository patientRepository;
  final TypeTherapyRepository typeTherapyRepository;

  AppointmentFormNotifier(
      {required this.appointmentRepository,
      required this.registerAppointmentCallback,
      required this.patientRepository,
      required String patientId,
      required this.typeTherapyRepository})
      : super(const AppointmentFormState()) {
    if (patientId.isNotEmpty) {
      state = state.copyWith(patientId: patientId);
      getPatient();
    }
    getTypeTherapics(); // ✅ Cargar áreas terapéuticas al iniciar

    initiaValues();
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
      print('🔹 Cargando áreas terapéuticas..');
      final areas = await typeTherapyRepository.getTypeTherapies();
      state = state.copyWith(areas: areas);
      print('🔹 Áreas terapéuticas cargadas: ${areas.length}');
    } catch (e) {
      state = state.copyWith(
          loading: false, errorMessage: 'Error al obtener áreas terapéuticas');
    }
  }

  Future<void> getPatient() async {
    try {
      print('🔹 Cargando paciente con el id: ' + state.patientId);
      state = state.copyWith(loading: true);
      final patient = await patientRepository.getPatient(state.patientId);
      state = state.copyWith(patientEntity: patient, loading: false);
    } on CustomError catch (e) {
      state = state.copyWith(loading: false, errorMessage: e.message);
    }
  }

  void initiaValues() {
    state = state.copyWith(
      selectedDate: DateTime.now(),
    );
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

      final newAppointment = CreateAppointments(
        date: state.selectedDate!,
        appointmentTime: state.selectedTime!,
        medicalInsurance: state.patientEntity?.healthInsurance ?? 'No seguro',
        diagnosis: state.diagnosis,
        patientId: state.patientId,
        specialtyTherapyId: state.specialtyTherapyId!,
      );
      print('🔹 Guardando cita...');

      await registerAppointmentCallback(newAppointment);
      state = state.copyWith(loading: false, errorMessage: '');
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
  final bool isFormPosted;
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
    this.isFormPosted = false,
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
    bool? isFormPosted,
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
      isFormPosted: isFormPosted ?? this.isFormPosted,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
