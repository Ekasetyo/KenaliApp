// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';

// import 'package:kenali_app/main.dart';

// void main() {
//   testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//     // Build the app and trigger a frame.
//     await tester.pumpWidget(const KenaliApp());

//     // Verify that the counter starts at 0.
//     expect(find.text('0'), findsOneWidget);
//     expect(find.text('1'), findsNothing);

//     // Tap the '+' icon and trigger a frame.
//     await tester.tap(find.byIcon(Icons.add));
//     await tester.pump();

//     // Verify that the counter has incremented.
//     expect(find.text('0'), findsNothing);
//     expect(find.text('1'), findsOneWidget);
//   });

//   testWidgets('Counter decrements smoke test', (WidgetTester tester) async {
//     // Build the app and trigger a frame.
//     await tester.pumpWidget(const KenaliApp());

//     // Tap the '+' icon twice to increment the counter.
//     await tester.tap(find.byIcon(Icons.add));
//     await tester.pump();
//     await tester.tap(find.byIcon(Icons.add));
//     await tester.pump();

//     // Verify that the counter is at 2.
//     expect(find.text('2'), findsOneWidget);

//     // Tap the '-' icon and trigger a frame.
//     await tester.tap(find.byIcon(Icons.remove));
//     await tester.pump();

//     // Verify that the counter has decremented.
//     expect(find.text('1'), findsOneWidget);
//     expect(find.text('2'), findsNothing);
//   });

//   testWidgets('Counter does not go below 0', (WidgetTester tester) async {
//     // Build the app and trigger a frame.
//     await tester.pumpWidget(const KenaliApp());

//     // Verify that the counter starts at 0.
//     expect(find.text('0'), findsOneWidget);

//     // Tap the '-' icon and trigger a frame.
//     await tester.tap(find.byIcon(Icons.remove));
//     await tester.pump();

//     // Verify that the counter does not go below 0.
//     expect(find.text('0'), findsOneWidget);
//     expect(find.text('-1'), findsNothing);
//   });
// }
