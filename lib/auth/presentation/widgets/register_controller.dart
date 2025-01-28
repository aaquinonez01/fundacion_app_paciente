import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fundacion_paciente_app/auth/presentation/widgets/register_form_part1.dart';
import 'package:fundacion_paciente_app/auth/presentation/widgets/register_form_part2.dart';
import 'package:fundacion_paciente_app/auth/presentation/widgets/register_form_part3.dart';
import 'package:fundacion_paciente_app/auth/presentation/providers/page_register.dart'; // Importamos el provider

class RegisterController extends ConsumerWidget {
  const RegisterController({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Obtenemos el estado de la página desde el provider
    final pageState = ref.watch(pageControllerProvider);
    final pageController = pageState
        .pageController; // Accedemos al PageController // Accedemos a la página actual

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.68,
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: (page) {
          ref
              .read(pageControllerProvider.notifier)
              .goToPage(page); // Actualiza la página en el provider
        },
        children: const [
          RegisterPatientPart1(),
          RegisterPatientPart2(),
          RegisterPatientPart3(),
        ],
      ),
    );
  }
}
