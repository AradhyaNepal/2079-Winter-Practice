import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_practice/counter_page/counter_page.dart';
import 'package:riverpod_practice/main.dart';

void main(){
  testWidgets("Plus Button Test", (tester) async{
    await tester.pumpWidget(
      const ProviderScope(
        child: CounterPage(),
      ),
    );
    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.text("0"), findsOneWidget);
    expect(find.text("1"), findsNothing);
    await _tapIcon(tester,Icons.add);
    expect(find.text("0"), findsNothing);
    expect(find.text("1"), findsOneWidget);
  });

  testWidgets("Minus Button Test", (tester) async{
    await tester.pumpWidget(
      const ProviderScope(
        child: CounterPage(),
      ),
    );
    expect(find.byIcon(Icons.remove), findsOneWidget);
    expect(find.text("0"), findsOneWidget);
    expect(find.text("-1"), findsNothing);
    await _tapIcon(tester,Icons.remove);
    expect(find.text("0"), findsNothing);
    expect(find.text("-1"), findsOneWidget);
  });

  testWidgets("After 10 plus, show warning test", (tester) async{
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: CounterPage()),
      ),
    );
    var zeroFinder=find.text("0");
    var tenValueTextFinder = find.text("10");
    expect(tenValueTextFinder, findsNothing);
    expect(zeroFinder, findsOneWidget);
    Text zeroDigitValue = tester.firstWidget(zeroFinder);
    expect(zeroDigitValue.style?.color==Colors.red, isFalse);
    expect(zeroDigitValue.style?.fontWeight==FontWeight.bold, isFalse);
    expect(find.byType(SnackBar), findsNothing);
    await _tapIcon(tester,Icons.add,10);
    await tester.pump();
    expect(tenValueTextFinder, findsOneWidget);
    expect(zeroFinder, findsNothing);
    Text tenValueTextWidget = tester.firstWidget(tenValueTextFinder);
    expect(tenValueTextWidget.style?.color==Colors.red, isTrue);
    expect(tenValueTextWidget.style?.fontWeight==FontWeight.bold, isTrue);
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.descendant(of: find.byType(SnackBar),matching: find.text("Value Too High")), findsOneWidget);
  });

  testWidgets("After 10 Minus, show warning test", (tester) async{
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: CounterPage()),
      ),
    );
    var zeroFinder=find.text("0");
    var negativeTenValueTextFinder = find.text("-10");
    expect(negativeTenValueTextFinder, findsNothing);
    expect(zeroFinder, findsOneWidget);
    Text zeroDigitValue = tester.firstWidget(zeroFinder);
    expect(zeroDigitValue.style?.color==Colors.red, isFalse);
    expect(zeroDigitValue.style?.fontWeight==FontWeight.bold, isFalse);
    expect(find.byType(SnackBar), findsNothing);
    await _tapIcon(tester,Icons.remove,10);
    await tester.pump();
    expect(negativeTenValueTextFinder, findsOneWidget);
    expect(zeroFinder, findsNothing);
    Text negativeTenValueTextWidget = tester.firstWidget(negativeTenValueTextFinder);
    expect(negativeTenValueTextWidget.style?.color==Colors.red, isTrue);
    expect(negativeTenValueTextWidget.style?.fontWeight==FontWeight.bold, isTrue);
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.descendant(of: find.byType(SnackBar),matching: find.text("Value Too Low")), findsOneWidget);
  });
  
  
  
  //At last
  testWidgets("Counter Reset on Page Reopen Test", (tester) async{
    await tester.pumpWidget(
      const ProviderScope(
          child: MyApp(),
      ),
    );
    await tester.tap(find.text(CounterPage.route));
    await tester.pumpAndSettle();
    expect(find.text("0"), findsOneWidget);
    await _tapIcon(tester,Icons.add);
    await tester.pump();
    expect(find.text("0"), findsNothing);
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.text(CounterPage.route));
    await tester.pumpAndSettle();
    expect(find.text("0"), findsOneWidget);
  });


  

}

Future<void> _tapIcon(WidgetTester tester,IconData iconData,[int times=1]) async {
  for(int i=0;i<times;i++){
    await tester.tap(find.byIcon(iconData));
  }
}