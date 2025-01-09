import 'package:fundacion_paciente_app/auth/presentation/screens/login_screen.dart';
import 'package:fundacion_paciente_app/auth/presentation/screens/register_screen.dart';
import 'package:fundacion_paciente_app/home/presentation/screens/home_screen.dart';
import 'package:fundacion_paciente_app/home/presentation/screens/register_patient_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: '/login', routes: [
  // Define the home route
  GoRoute(
      path: '/login',
      name: LoginScreen.name,
      builder: (context, state) => const LoginScreen()),
  GoRoute(
    path: '/register',
    name: RegisterScreen.name,
    builder: (context, state) => const RegisterScreen(),
  ),
  GoRoute(
      path: '/home',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen()),

  GoRoute(
      path: '/register-patient',
      name: RegisterPatientScreen.name,
      builder: (context, state) => const RegisterPatientScreen())
]);
