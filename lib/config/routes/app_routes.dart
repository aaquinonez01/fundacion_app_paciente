import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fundacion_paciente_app/auth/presentation/providers/auth_provider.dart';
import 'package:fundacion_paciente_app/auth/presentation/screens/check_auth_status_screen.dart';
import 'package:fundacion_paciente_app/auth/presentation/screens/forgot_password_screen.dart';
import 'package:fundacion_paciente_app/auth/presentation/screens/login_screen.dart';
import 'package:fundacion_paciente_app/auth/presentation/screens/register_screen.dart';
import 'package:fundacion_paciente_app/auth/presentation/screens/reset_password_screen.dart';
import 'package:fundacion_paciente_app/auth/presentation/screens/verify_code_screen.dart';
import 'package:fundacion_paciente_app/config/routes/app_router_notifier.dart';
import 'package:fundacion_paciente_app/home/presentation/screens/home_screen.dart';
import 'package:fundacion_paciente_app/home/presentation/screens/registerappointment_screen.dart';
import 'package:go_router/go_router.dart';

final goRouterProvider = Provider((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: goRouterNotifier,
    routes: [
      ///* Primera pantalla
      GoRoute(
        path: '/splash',
        builder: (context, state) => const CheckAuthStatusScreen(),
      ),

      GoRoute(
          path: '/register-appointment',
          builder: (context, state) {
            return const RegisterAppointment();
          }),

      ///* Auth Routes
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
          path: '/forgot-password',
          builder: (context, state) => const ForgotPasswordScreen()),
      GoRoute(
        path: '/reset-password/code',
        builder: (context, state) => const VerifyCodeScreen(),
      ),
      GoRoute(
          path: '/reset-password/new-password',
          builder: (context, state) => const ResetPasswordScreen()),

      ///* Product Routes
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
    ],
    redirect: (context, state) {
      final isGoingTo = state.uri.path;
      final authStatus = goRouterNotifier.authStatus;

      if (isGoingTo == '/splash' && authStatus == AuthStatus.checking)
        return null;

      if (authStatus == AuthStatus.notAuthenticated) {
        if (isGoingTo == '/login' ||
            isGoingTo == '/register' ||
            isGoingTo == '/forgot-password' ||
            isGoingTo == '/reset-password/code' ||
            isGoingTo == '/reset-password/new-password') {
          return null;
        }

        return '/login';
      }

      if (authStatus == AuthStatus.authenticated) {
        if (isGoingTo == '/login' ||
            isGoingTo == '/register' ||
            isGoingTo == '/splash') {
          return '/';
        }
      }

      return null;
    },
  );
});
