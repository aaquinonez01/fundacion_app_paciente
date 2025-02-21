import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fundacion_paciente_app/auth/presentation/providers/auth_provider.dart';
import 'package:fundacion_paciente_app/home/presentation/providers/appointments_provider.dart';
import 'package:fundacion_paciente_app/home/presentation/widgets/appointment_calendar.dart';
import 'package:fundacion_paciente_app/home/presentation/widgets/home_view.dart';
import 'package:fundacion_paciente_app/shared/presentation/widgets/header.dart';
import 'package:go_router/go_router.dart';
import 'package:fundacion_paciente_app/home/presentation/widgets/appointment_list.dart';

class HomeScreen extends ConsumerWidget {
  static const String name = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AppointmentState>(appointmentProvider, (previous, next) {
      if (next.errorMessage.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    });

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                ref.read(authProvider.notifier).logout();
              },
            ),
          ],
          toolbarHeight: 80,
          flexibleSpace: const Padding(
            padding: EdgeInsets.only(top: 20, left: 40),
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
              Tab(text: 'Inicio'),
              Tab(text: 'Agenda de Citas'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            HomeView(),
            AppointmentCalendar(),
          ],
        ),
      ),
    );
  }
}
