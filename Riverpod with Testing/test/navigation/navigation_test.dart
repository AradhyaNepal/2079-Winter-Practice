import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_practice/choose_action/widgets/custom_select_page_button.dart';
import 'package:riverpod_practice/counter_page/counter_page.dart';
import 'package:riverpod_practice/fake_server_fetch/server_fetch_page.dart';
import 'package:riverpod_practice/main.dart';

void main(){
  testWidgets("Testing Main Page Opens", (tester) async{
    await tester.pumpWidget(
      const ProviderScope(
          child: MyApp(),
      ),
    );
    expect(find.text("Riverpod Practice"), findsOneWidget);
    expect(find.byType(CustomSelectPageButton), findsNWidgets(2));
  });

  testWidgets("Testing Counter Page Navigation", (tester) async{
    await tester.pumpWidget(
      const ProviderScope(
        child: MyApp(),
      ),
    );
    expect(find.byType(CounterPage), findsNothing);
    await tester.tap(find.text(CounterPage.route));
    await tester.pumpAndSettle();
    expect(find.byType(CounterPage), findsOneWidget);
  });

  testWidgets("Testing Server Fetch Page Navigation", (tester) async{
    await tester.pumpWidget(
      const ProviderScope(
        child: MyApp(),
      ),
    );
    expect(find.byType(ServerFetchPage), findsNothing);
    await tester.tap(find.text(ServerFetchPage.route));
    await tester.pumpAndSettle();
    expect(find.byType(ServerFetchPage), findsOneWidget);
  });

}