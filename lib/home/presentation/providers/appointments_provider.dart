import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fundacion_paciente_app/auth/infrastructure/errors/auth_errors.dart';
import 'package:fundacion_paciente_app/home/domain/entities/cita.entity.dart';
import 'package:fundacion_paciente_app/home/domain/entities/registerCita.entity.dart';
import 'package:fundacion_paciente_app/home/domain/repositories/appointment_repository.dart';
import 'package:fundacion_paciente_app/home/infrastructure/repositories/appointment_repository_impl.dart';
import 'package:fundacion_paciente_app/config/routes/app_routes.dart';

// 🔹 Provider del estado de las citas médicas
final appointmentProvider =
    StateNotifierProvider<AppointmentNotifier, AppointmentState>((ref) {
  final repository = AppointmentRepositoryImpl();
  return AppointmentNotifier(repository, ref: ref);
});

// 🔹 Notifier que maneja el estado de las citas médicas
class AppointmentNotifier extends StateNotifier<AppointmentState> {
  final AppointmentRepository repository;
  final Ref ref;

  AppointmentNotifier(this.repository, {required this.ref})
      : super(AppointmentState(calendarioCitaSeleccionada: DateTime.now())) {
    getAppointmentsByDate(state
        .calendarioCitaSeleccionada); // ✅ Cargar citas del día actual al iniciar
    getAppointments(); // ✅ Cargar todas las citas al iniciar
  }

  /// 🔹 Obtener todas las citas
  Future<void> getAppointments() async {
    try {
      state = state.copyWith(loading: true);
      print('🔹 Cargando todas las citas...');
      final appointments = await repository.getAppointments();
      state = state.copyWith(
          loading: false, appointments: appointments, errorMessage: '');
      print('✅ Citas cargadas: ${appointments.length}');
    } on CustomError catch (e) {
      print('Error al obtener las citas: $e');
      state = state.copyWith(
          loading: false, errorMessage: 'Error al obtener las citas');
    }
  }

  /// 🔹 Obtener citas por fecha
  Future<void> getAppointmentsByDate(DateTime date) async {
    try {
      print('🔹 Cargando citas por fecha...');
      state = state.copyWith(loading: true);
      print('🔹 Buscando citas para la fecha: $date');

      final formattedDate = date.toIso8601String().split('T')[0]; // YYYY-MM-DD
      final appointments =
          await repository.getAppointmentsByDate(DateTime.parse(formattedDate));

      state = state.copyWith(
        loading: false,
        appointmentsByDate: appointments,
        calendarioCitaSeleccionada: date,
      );

      print('✅ Citas encontradas: ${appointments.length}');
    } on CustomError catch (e) {
      state = state.copyWith(
        loading: false,
        errorMessage: 'Error al obtener citas por fecha',
        appointmentsByDate: const [],
      );
    }
  }

  /// 🔹 Crear una nueva cita
  Future<void> createAppointment(CreateAppointments newAppointment) async {
    try {
      state = state.copyWith(loading: true);
      print('🔹 Creando nueva cita...');

      await repository.createAppointment(newAppointment);
      print('✅ Cita creada exitosamente');
      // 🔹 Recargar citas después de crear una nueva
      await getAppointments();
      state = state.copyWith(
          loading: false,
          errorMessage: '',
          successMessage: 'Cita creada exitosamente');
      ref.read(goRouterProvider).pop();
    } on CustomError catch (e) {
      print('Error al crear la cita: ${e.message}');
      state = state.copyWith(
          loading: false, errorMessage: 'Error al crear la cita: ' + e.message);
    }
  }

  void onDateSelected(DateTime date) async {
    state = state.copyWith(calendarioCitaSeleccionada: date);
    await getAppointmentsByDate(date);
  }

  /// 🔹 Seleccionar una cita específica
  void selectAppointment(Appointments appointment) {
    state = state.copyWith(selectedAppointment: appointment);
  }
}

// 📌 Estado del provider de citas médicas
class AppointmentState {
  final List<Appointments> appointments;
  final List<Appointments> appointmentsByDate;
  final Appointments? selectedAppointment;
  final DateTime calendarioCitaSeleccionada;
  final bool loading;
  final String errorMessage;
  final String successMessage;

  AppointmentState({
    this.appointments = const [],
    this.appointmentsByDate = const [],
    this.selectedAppointment,
    DateTime? calendarioCitaSeleccionada,
    this.loading = false,
    this.errorMessage = '',
    this.successMessage = '',
  }) : calendarioCitaSeleccionada = calendarioCitaSeleccionada ??
            DateTime.now(); // 🔹 Asigna un valor predeterminado

  AppointmentState copyWith({
    List<Appointments>? appointments,
    List<Appointments>? appointmentsByDate,
    Appointments? selectedAppointment,
    DateTime? calendarioCitaSeleccionada,
    bool? loading,
    String? errorMessage,
    String? successMessage,
  }) {
    return AppointmentState(
      appointments: appointments ?? this.appointments,
      appointmentsByDate: appointmentsByDate ?? this.appointmentsByDate,
      selectedAppointment: selectedAppointment ?? this.selectedAppointment,
      calendarioCitaSeleccionada:
          calendarioCitaSeleccionada ?? this.calendarioCitaSeleccionada,
      successMessage: successMessage ?? this.successMessage,
      loading: loading ?? this.loading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
