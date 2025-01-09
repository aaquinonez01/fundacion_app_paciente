import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  static const String name = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context.go('/login');
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 150),
          child: _Home_View_Screen(),
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class _Home_View_Screen extends StatelessWidget {
  final String nameUser = 'David';
  const _Home_View_Screen();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Text(
            '¡Bienvenido, $nameUser !',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colors.primary,
              fontSize: 38,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Para empezar, necesitamos registrar a tu paciente. Solo será necesario una vez.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colors.secondary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                context.push('/register-patient');
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.blue),
                shape: WidgetStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40))),
              ),
              child: const Text('Comenzar registro del paciente',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
