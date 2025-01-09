import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fundacion_paciente_app/home/presentation/widgets/register_patient_part1.dart';
import 'package:fundacion_paciente_app/home/presentation/widgets/register_patient_part2.dart';
import 'package:fundacion_paciente_app/home/presentation/providers/page_register_patient.dart'; // Importamos el provider

class RegisterPatientController extends ConsumerWidget {
  const RegisterPatientController({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Obtenemos el estado de la página desde el provider
    final pageState = ref.watch(pageControllerProvider);
    final pageController =
        pageState.pageController; // Accedemos al PageController
    final currentPage = pageState.currentPage; // Accedemos a la página actual

    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: pageController,
            onPageChanged: (page) {
              ref
                  .read(pageControllerProvider.notifier)
                  .goToPage(page); // Actualiza la página en el provider
            },
            children: const [
              RegisterPatientPart1(),
              RegisterPatientPart2(),
            ],
          ),
        ),
      ],
    );
  }
}
