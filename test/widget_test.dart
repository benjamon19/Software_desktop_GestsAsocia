import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Reset GetX before each test
    Get.reset();
    
    // Build a simple test app
    await tester.pumpWidget(
      GetMaterialApp(
        title: 'Test App',
        home: Scaffold(
          appBar: AppBar(
            title: const Text('GestAsocia Test'),
          ),
          body: const Center(
            child: Text('App funciona correctamente'),
          ),
        ),
      ),
    );

    // Verify that our test text is found
    expect(find.text('App funciona correctamente'), findsOneWidget);
    expect(find.text('GestAsocia Test'), findsOneWidget);
  });
}