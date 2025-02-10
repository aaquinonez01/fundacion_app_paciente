import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fundacion_paciente_app/auth/presentation/providers/auth_provider.dart';
import 'package:fundacion_paciente_app/shared/presentation/widgets/header.dart';

import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends ConsumerWidget {
  static const String name = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                ref.read(authProvider.notifier).logout();
              },
            ),
          ],
          toolbarHeight: 80,
          flexibleSpace: const Padding(
            padding: EdgeInsets.only(top: 20, left: 40), // Ajustar margen
            child: Header(
              heightScale: 0.80,
              imagePath: 'assets/images/logo.png',
              title: 'Fundación de niños especiales',
              subtitle: '"SAN MIGUEL" FUNESAMI',
              item: '"Inicio, Agenda de Citas"',
            ),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Inicio',
              ),
              Tab(
                text: 'Agenda de Citas',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _Home_View_Screen(),
            Appointment(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class _Home_View_Screen extends ConsumerWidget {
  const _Home_View_Screen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).user;
    final colors = Theme.of(context).colorScheme;
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              '¡Bienvenido, ${user!.userInformation.firstName}!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colors.primary,
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Fundación de niños especiales "SAN MIGUEL" FUNESAMI',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colors.secondary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Tus Citas Agendadas',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class Appointment extends StatelessWidget {
  const Appointment({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
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
              focusedDay: DateTime.now(),
              firstDay: DateTime.utc(2020, 10, 16),
              lastDay: DateTime.utc(2040, 3, 14)),
        ),
        const SizedBox(
          height: 10,
        ),
        Center(
          child: Text('Citas Agendadas para el día de hoy',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary)),
        ),
        const SizedBox(
          height: 10,
        ),
        // const Expanded(
        //   child: Center(
        //     child: Text('No tienes citas agendadas',
        //         style: TextStyle(
        //             fontSize: 18,
        //             fontWeight: FontWeight.bold,
        //             color: Colors.grey)),
        //   ),
        // ),
        //Cuando si tengo citas agendadas para ese dia
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 3.0), // Espaciado entre cards
                  child: Card(
                    elevation: 3, // Sombra para la tarjeta
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(15), // Bordes redondeados
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 16), // Espaciado interno
                      leading: Container(
                        padding: const EdgeInsets.all(7),
                        decoration: const BoxDecoration(
                          color: Colors.blueAccent, // Color del icono
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.calendar_today,
                            color: Colors.white),
                      ),
                      title: Text(
                        'Cita Médica $index',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      subtitle: const Text(
                        'Hora: 10:00 AM',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      trailing: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.visibility_outlined),
                        label:
                            const Text("Ver", style: TextStyle(fontSize: 12)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green, // Color del botón
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
