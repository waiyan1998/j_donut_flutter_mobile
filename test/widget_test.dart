import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:j_donut_flutter_mobile/app.dart';
import 'package:j_donut_flutter_mobile/features/home/presentation/screens/home_screen.dart';

void main() {
  testWidgets('J’Donuts opens on the phone sign-in screen', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: JDonutsApp()));
    await tester.pumpAndSettle();

    expect(find.text("J'Donuts"), findsOneWidget);
    expect(find.text('Your treat is waiting'), findsOneWidget);
    expect(find.text('Send me a code'), findsOneWidget);
  });

  testWidgets('phone sign-in opens the live OTP verification view', (
    tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: JDonutsApp()));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).first, '9123456789');
    expect(tester.testTextInput.isVisible, isTrue);
    await tester.tap(find.text("J'Donuts"));
    await tester.pump();
    expect(tester.testTextInput.isVisible, isFalse);

    await tester.tap(find.byType(TextField).first);
    await tester.enterText(find.byType(TextField).first, '9123456789');
    await tester.tap(find.text('Send me a code'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text('Check your messages'), findsOneWidget);
    expect(tester.testTextInput.isVisible, isFalse);
    await tester.tap(find.byType(TextField).first);
    await tester.enterText(find.byType(TextField).first, '1234');
    expect(tester.testTextInput.isVisible, isTrue);
    await tester.tap(find.text('Check your messages'));
    await tester.pump();
    expect(tester.testTextInput.isVisible, isFalse);

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Text &&
            widget.textSpan?.toPlainText().contains('05:00') == true,
      ),
      findsOneWidget,
    );
    expect(find.text('Verify & continue'), findsOneWidget);
  });

  testWidgets('login and OTP forms stay above the keyboard', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetViewInsets);

    await tester.pumpWidget(const ProviderScope(child: JDonutsApp()));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).first, '9123456789');
    tester.view.viewInsets = const FakeViewPadding(bottom: 300);
    await tester.pumpAndSettle();
    expect(
      tester.getRect(find.text('Send me a code')).bottom,
      lessThanOrEqualTo(544),
    );

    await tester.tap(find.text('Send me a code'));
    tester.view.viewInsets = FakeViewPadding.zero;
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    await tester.tap(find.byType(TextField).first);
    await tester.enterText(find.byType(TextField).first, '1234');
    tester.view.viewInsets = const FakeViewPadding(bottom: 300);
    await tester.pumpAndSettle();
    expect(
      tester.getRect(find.text('Verify & continue')).bottom,
      lessThanOrEqualTo(544),
    );
  });

  testWidgets('banner auto-slide handles detached page view', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: HomeScreen())),
    );
    await tester.pump();

    await tester.pump(const Duration(seconds: 4));
    await tester.pump(const Duration(milliseconds: 600));

    await tester.tap(find.text('Shops'));
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pump(const Duration(seconds: 4));
    await tester.pump(const Duration(milliseconds: 600));

    expect(tester.takeException(), isNull);
  });

  testWidgets('any four-digit code opens the catalog and rewards', (
    tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: JDonutsApp()));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).first, '9123456789');
    await tester.tap(find.text('Send me a code'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    await tester.enterText(find.byType(TextField).first, '1234');
    await tester.tap(find.text('Verify & continue'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 750));
    await tester.pump(const Duration(milliseconds: 600));

    expect(find.text('Hi, May! 🍩'), findsOneWidget);
    await tester.tap(find.text('Rewards'));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Sweet rewards'), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 1900));
    expect(find.text('1,250 pts'), findsOneWidget);
  });
}
