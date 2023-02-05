import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_practice/fake_server_fetch/provider/filter_data_provider.dart';
import 'package:riverpod_practice/fake_server_fetch/server_fetch_page.dart';
import 'package:riverpod_practice/fake_server_fetch/utils/text_from_enum.dart';
import 'package:riverpod_practice/main.dart';

void main(){
  testWidgets("Filter Changing Button Works", (tester) async{
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
            home: ServerFetchPage()
        ),
      ),
    );
    
    //By default All selected
    _allSelectedTest(tester);
    //Now Checked Selected
    await tester.tap(find.text(getTextFromEnum(SelectedFilter.checked)));
    await tester.pump();
    _checkedSelectedTest(tester);
    //Now Unchecked Selected
    await tester.tap(find.text(getTextFromEnum(SelectedFilter.unchecked)));
    await tester.pump();
    _uncheckedSelectedTest(tester);
    //Now All Selected Again
    await tester.tap(find.text(getTextFromEnum(SelectedFilter.all)));
    await tester.pump();
    _allSelectedTest(tester);
    await tester.pumpAndSettle();
  });
  
  testWidgets("All Filter checked, when page reloads", (tester)async{
    await tester.pumpWidget(
      const ProviderScope(
        child: MyApp(),
      ),
    );
    await _tapServerFetchAndPumpSettle(tester);
    _allSelectedTest(tester);
    await tester.tap(find.text(getTextFromEnum(SelectedFilter.checked)));
    await tester.pump();
    _checkedSelectedTest(tester);
    await _goBackAndPumpSettle(tester);
    await _tapServerFetchAndPumpSettle(tester);
    _allSelectedTest(tester);
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

void _uncheckedSelectedTest(WidgetTester tester) {
  expect(_isSelected(tester,getTextFromEnum(SelectedFilter.all)),isFalse);
  expect(_isSelected(tester,getTextFromEnum(SelectedFilter.checked)),isFalse);
  expect(_isSelected(tester,getTextFromEnum(SelectedFilter.unchecked)),isTrue);
}

void _checkedSelectedTest(WidgetTester tester) {
   expect(_isSelected(tester,getTextFromEnum(SelectedFilter.all)),isFalse);
  expect(_isSelected(tester,getTextFromEnum(SelectedFilter.checked)),isTrue);
  expect(_isSelected(tester,getTextFromEnum(SelectedFilter.unchecked)),isFalse);
}

void _allSelectedTest(WidgetTester tester) {
  expect(_isSelected(tester,getTextFromEnum(SelectedFilter.all)),isTrue);
  expect(_isSelected(tester,getTextFromEnum(SelectedFilter.checked)),isFalse);
  expect(_isSelected(tester,getTextFromEnum(SelectedFilter.unchecked)),isFalse);
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