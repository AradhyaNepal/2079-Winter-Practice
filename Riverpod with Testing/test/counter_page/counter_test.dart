import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_practice/counter_page/counter_page.dart';
import 'package:riverpod_practice/main.dart';

void main(){
  testWidgets("Counter Reset Test", (tester) async{
    await tester.pumpWidget(
      const ProviderScope(
          child: MyApp(),
      ),
    );
    await tester.tap(find.text(CounterPage.route));
    await tester.pumpAndSettle();
    expect(find.text("0"), findsOneWidget);
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.text("0"), findsNothing);
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.text(CounterPage.route));
    await tester.pumpAndSettle();
    expect(find.text("0"), findsOneWidget);
  });

}