import 'package:flutter/material.dart';
import 'package:flutter_mobile_engineer/app/modules/tables/controllers/tables_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_mobile_engineer/main.dart' as app;

import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRepository extends Mock implements TablesController {}

void main() {

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();



  testWidgets('Open app in offline mode in cache mode', (tester) async {
    /*Given*/
    app.main();
    await tester.pumpAndSettle();
    /*When*/
    var tablesScreem = find.byKey(const Key('Screen_with_tables'));
    expect(tablesScreem, findsOneWidget);

    /*Then*/
    final dialog = find.byKey(const Key('List_of_tables_is_visible'));
    expect(dialog, findsOneWidget);
    var listTable= find.byKey(const Key('List_of_tables_is_visible'));
    GridView listWidget = tester.widget<GridView>(listTable);
    expect(listWidget.childrenDelegate.estimatedChildCount, 13);
  });

  testWidgets('Table reservation', (tester) async {
    /*Given*/
    app.main();
    await tester.pumpAndSettle();
    var listTable= find.byKey(const Key('List_of_tables_is_visible'));
    var freTable=find.text('Free');
    expect(listTable, findsOneWidget);
    expect(freTable, findsAtLeastNWidgets(1));
    /*When*/
    await tester.tap(freTable.first);
    await tester.pumpAndSettle();

    /*Then*/
    var customerScreen = find.byKey(const Key('Screen_with_users_tables'));
    expect(customerScreen, findsOneWidget);
    /*When*/
    var customer = find.byType(ListTile).first;
    await tester.tap(customer);
    await tester.pumpAndSettle();

    /*Then*/
    var tableScreen = find.byKey(const Key('Screen_with_tables'));
    await tester.pumpAndSettle();
    expect(tableScreen, findsOneWidget);
  });

  testWidgets('Table reservation cancellation', (tester) async {
    /*Given*/
    app.main();
    await tester.pumpAndSettle();
    var listTable= find.byKey(const Key('List_of_tables_is_visible'));
    expect(listTable, findsOneWidget);
    var userReservation=find.byType(ListTile);
    expect(userReservation, findsAtLeastNWidgets(1));
    /*When*/
    await tester.tap(userReservation.first);
    await tester.pumpAndSettle();

    /*Then*/
    var customerScreen = find.byType(AlertDialog);
    expect(customerScreen, findsOneWidget);

    /*When*/
    var customer = find.byType(TextButton).first;
    await tester.tap(customer);
    await tester.pumpAndSettle();
    /*Then*/
    var tableScreen = find.byKey(const Key('Screen_with_tables'));
    await tester.pumpAndSettle();
    expect(tableScreen, findsOneWidget);
  });

  testWidgets('Reserved table visual feedback', (tester) async {
    /*Given*/
    app.main();
    await tester.pumpAndSettle();
    var userReservation=find.byType(ListTile);
    expect(userReservation, findsAtLeastNWidgets(1));

    /*When*/
    final dialog = find.byKey(const Key('List_of_tables_is_visible'));
    expect(dialog, findsOneWidget);

    /*Then*/
    var customerImage = find.byKey(const Key('customer_image')).first;
    var customerName = find.byKey(const Key('customer_name')).first;
    expect(customerImage, findsOneWidget);
    expect(customerName, findsOneWidget);
  });
}
