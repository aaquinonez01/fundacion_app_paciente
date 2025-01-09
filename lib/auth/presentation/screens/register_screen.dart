import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fundacion_paciente_app/auth/presentation/widgets/register_form.dart';

class RegisterScreen extends StatelessWidget {
  static const name = 'register-screen';
  const RegisterScreen({super.key});

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
                height: 10,
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue[200],
                      borderRadius: BorderRadius.circular(100)),
                  child: Image.network(
                    'https://wilsonclinic.com/wp-content/uploads/2018/12/placeholder-logo-2.png',
                    width: 150,
                    height: 150,
                  ),
                ),
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
                height: 20,
              ),
              const RegisterForm(),
              const SizedBox(
                height: 10,
              ),
              //Has olvidado tu contraseña

              //Registrarse
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('¿Ya tienes cuenta?',
                      style: TextStyle(fontSize: 18)),
                  TextButton(
                    onPressed: () {
                      context.go('/login');
                    },
                    child:
                        const Text('Ingresar', style: TextStyle(fontSize: 18)),
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
