import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_practice/fake_server_fetch/provider/filter_data_provider.dart';
import 'package:riverpod_practice/fake_server_fetch/provider/server_data_provider.dart';
import 'package:riverpod_practice/fake_server_fetch/repository/fake_data.dart';
import 'package:riverpod_practice/fake_server_fetch/server_fetch_page.dart';
import 'package:riverpod_practice/fake_server_fetch/utils/text_from_enum.dart';
import 'package:riverpod_practice/fake_server_fetch/widgets/data_list_widget.dart';
import 'package:riverpod_practice/fake_server_fetch/widgets/individual_data_widget.dart';
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
    await _selectCheckedAndPump(tester);
    _checkedSelectedTest(tester);
    //Now Unchecked Selected
    await _selectUncheckedAndPump(tester);
    _uncheckedSelectedTest(tester);
    //Now All Selected Again
    await _selectAllAndPump(tester);
    _allSelectedTest(tester);
    await tester.pumpAndSettle();
  });

  testWidgets("Checked And UnChecked Button Properly Showing Data", (tester)async{
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          serverDataProvider.overrideWith((ref) => _getFakeData()),
        ],
        child: const MaterialApp(
          home: ServerFetchPage(),
        ),
      )
    );
    _allSelectedTest(tester);
    expect(_haveCheckedValue(tester) && _haveUnCheckedValue(tester), isTrue);
    await _selectCheckedAndPump(tester);
    _checkedSelectedTest(tester);
    expect(_haveCheckedValue(tester), isTrue);
    await _selectUncheckedAndPump(tester);
    _uncheckedSelectedTest(tester);
    expect(_haveUnCheckedValue(tester), isTrue);

  });

  testWidgets("No Data Available", (tester)async{
    await tester.pumpWidget(
        ProviderScope(
          overrides: [
            serverDataProvider.overrideWith((ref) => []),
          ],
          child: const MaterialApp(
            home: ServerFetchPage(),
          ),
        )
    );
   await tester.pumpAndSettle();
   _allSelectedTest(tester);
   expect(find.text("No Data available"), findsOneWidget);
   await _selectCheckedAndPump(tester);
   expect(find.text("No Data available"), findsOneWidget);
   await _selectUncheckedAndPump(tester);
   expect(find.text("No Data available"), findsOneWidget);
  });

  testWidgets("Some Data Available", (tester)async{
    await tester.pumpWidget(
        ProviderScope(
          overrides: [
            serverDataProvider.overrideWith((ref) => _getFakeData()),
          ],
          child: const MaterialApp(
            home: ServerFetchPage(),
          ),
        )
    );
   await tester.pumpAndSettle();
   _allSelectedTest(tester);
   expect(find.text("No Data available"), findsNothing);
   await _selectCheckedAndPump(tester);
   expect(find.text("No Data available"), findsNothing);
   await _selectUncheckedAndPump(tester);
   expect(find.text("No Data available"), findsNothing);
  });

  testWidgets("Check and Uncheck is working both in UI and Internally, for all filter", (tester) async{
    final container=ProviderContainer(
      overrides: [
        serverDataProvider.overrideWith((ref) => _getFakeData()),
      ],
    );
    await tester.pumpWidget(
      ProviderScope(
        parent: container,
        child: const MaterialApp(
          home: ServerFetchPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(_haveCheckedValue(tester), isTrue);
    expect(_internallyHaveCheckedList(container), isTrue);
    await tester.tap(find.byWidget(_getCheckedValue(tester).first));
    await tester.pumpAndSettle();
    expect(_haveCheckedValue(tester), isFalse);
    expect(_internallyHaveCheckedList(container), isFalse);
    await tester.tap(find.byWidget(_getUnCheckedValue(tester).first));
    await tester.pumpAndSettle();
    expect(_haveCheckedValue(tester), isTrue);
    expect(_internallyHaveCheckedList(container), isTrue);
    addTearDown(() {
      container.dispose();
    });
  });

  testWidgets("Uncheck and disappear both in UI and Internally, for all checked", (tester) async{
    final container=ProviderContainer(
      overrides: [
        serverDataProvider.overrideWith((ref) => _getFakeData()),
      ],
    );
    final checkedFakeData=container.read(serverDataProvider).value!.where((element) => element.checked==true).first;
    await tester.pumpWidget(
      ProviderScope(
        parent: container,
        child: const MaterialApp(
          home: ServerFetchPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await _selectCheckedAndPump(tester);
    expect(find.byKey(ValueKey(checkedFakeData.id)), findsOneWidget);
    expect(_haveTheChosenElement(container, checkedFakeData.id), isTrue);
    await tester.tap(
      find.descendant(of: find.byKey(ValueKey(checkedFakeData.id)), matching: find.byType(Checkbox))
    );
    await tester.pumpAndSettle();
    expect(find.byKey(ValueKey(checkedFakeData.id)), findsNothing);
    expect(_haveTheChosenElement(container, checkedFakeData.id), isFalse);
    addTearDown(() {
      container.dispose();
    });
  });

  testWidgets("Check and disappear both in UI and Internally, for all unchecked", (tester) async{
    final container=ProviderContainer(
      overrides: [
        serverDataProvider.overrideWith((ref) => _getFakeData()),
      ],
    );
    final checkedFakeData=container.read(serverDataProvider).value!.where((element) => element.checked==false).first;
    await tester.pumpWidget(
      ProviderScope(
        parent: container,
        child: const MaterialApp(
          home: ServerFetchPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await _selectUncheckedAndPump(tester);
    expect(find.byKey(ValueKey(checkedFakeData.id)), findsOneWidget);
    expect(_haveTheChosenElement(container, checkedFakeData.id), isTrue);
    await tester.tap(
        find.descendant(of: find.byKey(ValueKey(checkedFakeData.id)), matching: find.byType(Checkbox))
    );
    await tester.pumpAndSettle();
    expect(find.byKey(ValueKey(checkedFakeData.id)), findsNothing);
    expect(_haveTheChosenElement(container, checkedFakeData.id), isFalse);
    addTearDown(() {
      container.dispose();
    });
  });


  //Needs mokito because we need to sepeate error scenario and non error scenario, since its unit test
  testWidgets("Refresh Loads new Data", (tester) async{
    final navigatorKey=GlobalKey<NavigatorState>();
    await tester.pumpWidget(
        ProviderScope(
          child:  MaterialApp(
            navigatorKey: navigatorKey,
            routes: {
              ServerFetchPage.route:(_)=>const ServerFetchPage(),
            },
            initialRoute: ServerFetchPage.route,
          ),
        )
    );
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pumpAndSettle();
    for(int i=0;i<10;i++){
      expect(find.byType(CircularProgressIndicator), findsNothing);
      if(tester.widgetList(find.byType(CustomErrorWidget)).isNotEmpty){
        await tester.tap(find.byType(CustomErrorWidget));
        await tester.pump();
      }else{
        await tester.fling(find.byType(IndividualDataWidget).first, const Offset(0, 1000),1000);
        await tester.pump();
      }
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pumpAndSettle();
      navigatorKey.currentState?.pushReplacementNamed(ServerFetchPage.route);
      await tester.pumpAndSettle();
    }

  });
  
  testWidgets("All Filter checked, when page reloads", (tester)async{
    await tester.pumpWidget(
      const ProviderScope(
        child: MyApp(),
      ),
    );
    await _tapServerFetchAndPumpSettle(tester);
    _allSelectedTest(tester);
    await _selectCheckedAndPump(tester);
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

bool _haveTheChosenElement(ProviderContainer container, int id) => container.read(filterDataProvider).where((element) => element.id==id).isNotEmpty;

bool _internallyHaveCheckedList(ProviderContainer container) => (container.read(localDataProvider) as List<FakeData>).where((element) => element.checked==true).isNotEmpty;

List<FakeData> _getFakeData() {
  return [
          FakeData(id: 1, title: "One", content: "One Two Three", checked: true),
          FakeData(id: 2, title: "Two", content: "One Two Three", checked: false),
        ];
}

bool _haveCheckedValue(WidgetTester tester) {
  return _getCheckedValue(tester).isNotEmpty;
}

Iterable<Widget> _getCheckedValue(WidgetTester tester) {
  return tester.widgetList(find.byType(Checkbox)).where((element){
  element=element as Checkbox;
  return element.value==true;
});
}
bool _haveUnCheckedValue(WidgetTester tester) {
  return _getUnCheckedValue(tester).isNotEmpty;
}

Iterable<Widget> _getUnCheckedValue(WidgetTester tester) {
  return tester.widgetList(find.byType(Checkbox)).where((element){
  element=element as Checkbox;
  return element.value==false;
});
}

Future<void> _selectAllAndPump(WidgetTester tester) async {
   await tester.tap(find.text(getTextFromEnum(SelectedFilter.all)));
  await tester.pump();
}

Future<void> _selectUncheckedAndPump(WidgetTester tester) async {
   await tester.tap(find.text(getTextFromEnum(SelectedFilter.unchecked)));
  await tester.pump();
}

Future<void> _selectCheckedAndPump(WidgetTester tester) async {
  await tester.tap(find.text(getTextFromEnum(SelectedFilter.checked)));
  await tester.pump();
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