import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_practice/fake_server_fetch/server_fetch_page.dart';
import 'package:riverpod_practice/main.dart';

void main(){
  testWidgets("All Filter checked, when page reloads", (tester)async{
    await tester.pumpWidget(
      const ProviderScope(
        child: MyApp(),
      ),
    );
    await _tapServerFetchAndPumpSettle(tester);
    expect(_isSelected(tester,"All"), isTrue);
    expect(_isSelected(tester,"Checked"), isFalse);
    await tester.tap(find.text("Checked"));
    await tester.pump();
    expect(_isSelected(tester,"All"), isFalse);
    expect(_isSelected(tester,"Checked"), isTrue);
    await _goBackAndPumpSettle(tester);
    await _tapServerFetchAndPumpSettle(tester);
    expect(_isSelected(tester,"All"), isTrue);
    expect(_isSelected(tester,"Checked"), isFalse);

  });

  testWidgets("Fetching new data when page reloads", (tester)async{
    await tester.pumpWidget(
       const ProviderScope(
         child: MyApp(),
       ));
    await _findLoadingTest(tester);
    await _goBackAndPumpSettle(tester);
    await _findLoadingTest(tester);

  });
}

Future<void> _goBackAndPumpSettle(WidgetTester tester) async {
  await tester.pageBack();
  await tester.pumpAndSettle();
}

Future<void> _findLoadingTest(WidgetTester tester) async {
  await tester.tap(find.text(ServerFetchPage.route));
  expect(find.byType(ServerFetchPage), findsNothing);
  await _pumpTillServerPageOpened(tester);
  expect(find.byType(ServerFetchPage), findsOneWidget);
  expect(find.byType(CircularProgressIndicator), findsOneWidget);
  await tester.pumpAndSettle();
}

Future<void> _pumpTillServerPageOpened(WidgetTester tester) async {
  while(tester.widgetList(find.byType(ServerFetchPage)).isEmpty){
    await tester.pump();
  }
}


Future<void> _tapServerFetchAndPumpSettle(WidgetTester tester) async {
  await tester.tap(find.text(ServerFetchPage.route));
  await tester.pumpAndSettle();
}

bool _isSelected(WidgetTester tester,String value) {
  var widgetFinder=find.text(value);
  Text allText=tester.firstWidget(widgetFinder);
  return allText.style?.color==Colors.red && allText.style?.fontWeight==FontWeight.w600;
}