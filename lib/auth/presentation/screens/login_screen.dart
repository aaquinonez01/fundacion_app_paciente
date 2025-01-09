import 'package:flutter/material.dart';
import 'package:fundacion_paciente_app/auth/presentation/widgets/login_form.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  static const name = 'login-screen';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 150,
                  height: 150,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  textAlign: TextAlign.center,
                  'BIENVENIDO A LA FUNDACION "FUNESAMI"',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: colors.primary),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const LoginForm(),
              const SizedBox(
                height: 10,
              ),
              //Has olvidado tu contraseña
              Container(
                decoration: const BoxDecoration(
                  border: Border.symmetric(
                    horizontal: BorderSide(color: Colors.black, width: 1),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('¿Olvidaste tu contraseña?'),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Recuperar'),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              //Registrarse
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('¿No tienes cuenta?',
                      style: TextStyle(fontSize: 18)),
                  TextButton(
                    onPressed: () {
                      context.go('/register');
                    },
                    child: const Text('Registrarse',
                        style: TextStyle(fontSize: 18)),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}