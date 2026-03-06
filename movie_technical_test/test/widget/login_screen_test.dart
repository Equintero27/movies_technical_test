import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_technical_test/features/auth/presentation/screens/login_screen.dart';

void main() {

  testWidgets('LoginScreen muestra campos y botón', (WidgetTester tester) async {

    await tester.pumpWidget(
      const MaterialApp(
        home: LoginScreen(),
      ),
    );

    // Verifica que existan los campos
    expect(find.byType(TextFormField), findsNWidgets(2));

    // Verifica el botón
    expect(find.text("Ingresar"), findsOneWidget);

    // Verifica el título
    expect(find.text("Movie Technical Test"), findsOneWidget);
  });


  testWidgets('Muestra error si los campos están vacíos', (WidgetTester tester) async {

    await tester.pumpWidget(
      const MaterialApp(
        home: LoginScreen(),
      ),
    );

    // Presiona el botón
    await tester.tap(find.text("Ingresar"));

    await tester.pump();

    // Debe aparecer el error
    expect(find.text("Por favor ingrese un valor"), findsWidgets);
  });

}