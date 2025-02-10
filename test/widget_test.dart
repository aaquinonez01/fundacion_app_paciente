import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fundacion_paciente_app/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Construye la app dentro de un ProviderScope
    await tester.pumpWidget(
      const ProviderScope(child: MainApp()), // Cambié MyApp a MainApp
    );

    // Verifica que el contador comienza en 0
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Simula un tap en el botón de incremento
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verifica que el contador se incrementó
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
