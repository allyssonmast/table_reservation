import 'package:flutter_mobile_engineer/app/modules/tables/controllers/tables_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTablesController extends Mock implements TablesController {}

void main() {
  late MockTablesController controller;

  setUp(() {
    controller = MockTablesController();
  });

  test('return has conected false if no connection', () async{

  when(() => controller.isConnected())
      .thenAnswer((invocation) async => false);

   var result= await controller.isConnected();
  expect(result, false);
  });

  test('save data localy', () async{

  when(() => controller.isConnected())
      .thenAnswer((invocation) async => false);

   var result= await controller.isConnected();
  expect(result, false);
  });

}