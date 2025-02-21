import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fundacion_paciente_app/home/presentation/providers/appointments_provider.dart';
import 'package:fundacion_paciente_app/home/presentation/widgets/appointment_list.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class AppointmentCalendar extends ConsumerWidget {
  const AppointmentCalendar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appointmentState = ref.watch(appointmentProvider);
    final notifier = ref.read(appointmentProvider.notifier);
    final selectedDate = appointmentState.calendarioCitaSeleccionada;

    return Column(
      children: [
        const SizedBox(height: 10),
        Text('CALENDARIO DE CITAS',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TableCalendar(
            availableGestures: AvailableGestures.all,
            locale: "es_EC",
            rowHeight: 42,
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
            focusedDay: selectedDate,
            firstDay: DateTime.utc(2020, 10, 16),
            lastDay: DateTime.utc(2040, 3, 14),
            selectedDayPredicate: (day) => isSameDay(day, selectedDate),
            onDaySelected: (selectedDay, focusedDay) {
              notifier.onDateSelected(selectedDay);
            },

            // 🔹 Personalización de los días con colores según estado
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, date, _) {
                try {
                  final citasDelDia =
                      appointmentState.appointments.where((cita) {
                    try {
                      final citaDate =
                          DateFormat('MMMM d, y', 'en_US').parse(cita.date);
                      return isSameDay(date, citaDate);
                    } catch (_) {
                      return false;
                    }
                  }).toList();

                  Color? backgroundColor;
                  if (citasDelDia.any((cita) => cita.status == 'Agendado')) {
                    backgroundColor = Colors.green; // Agendado
                  } else if (citasDelDia
                      .any((cita) => cita.status == 'Pendiente')) {
                    backgroundColor = Colors.orange; // Pendiente
                  }

                  return Container(
                    margin: const EdgeInsets.all(4),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: backgroundColor ?? Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${date.day}',
                      style: TextStyle(
                        color: backgroundColor != null
                            ? Colors.white
                            : Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                } catch (_) {
                  return null;
                }
              },
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Citas Agendadas para ${DateFormat('yyyy-MM-dd').format(selectedDate)}',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: appointmentState.loading
                ? const Center(child: CircularProgressIndicator())
                : appointmentState.appointmentsByDate.isEmpty
                    ? const Center(
                        child: Text(
                          'No tienes citas agendadas para esta fecha',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                      )
                    : AppointmentList(
                        appointments: appointmentState.appointmentsByDate),
          ),
        ),
      ],
    );
  }
}
