import 'package:flutter/material.dart';
import 'package:fundacion_paciente_app/auth/presentation/widgets/register_controller.dart';
import 'package:go_router/go_router.dart';

import 'package:fundacion_paciente_app/shared/presentation/widgets/header.dart';

class RegisterScreen extends StatelessWidget {
  static const name = 'register-screen';
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Header(
                  heightScale: 1.0,
                  imagePath: 'assets/images/logo.png',
                  title: 'Fundación de niños especiales',
                  subtitle: '"SAN MIGUEL" FUNESAMI',
                  item: '"Registro de Usuario"',
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    'CREA TU CUENTA EN FUNESAMI',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: colors.primary),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const RegisterController(),
                const SizedBox(
                  height: 10,
                ),
                //Has olvidado tu contraseña

                //Registrarse
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     const Text('¿Ya tienes cuenta?',
                //         style: TextStyle(fontSize: 18)),
                //     TextButton(
                //       onPressed: () {
                //         context.go('/login');
                //       },
                //       child:
                //           const Text('Ingresar', style: TextStyle(fontSize: 18)),
                //     )
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
