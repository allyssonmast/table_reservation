import 'package:flutter_mobile_engineer/app/data/restaurant_repository.dart';
import 'package:flutter_mobile_engineer/app/modules/tables/models/customers.dart';
import 'package:flutter_mobile_engineer/app/modules/tables/models/reservations.dart';
import 'package:flutter_mobile_engineer/app/modules/tables/models/tables.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRepository extends Mock implements RestaurantRepository {}

void main() {
  late MockRepository repository;

  setUp(() {
    repository = MockRepository();
  });

  test('should return remote List<Tables> data when called', () async {
    List<Tables> listTables = [];
    Tables tables = const Tables(shape: 'square', id: 100);

    listTables.add(tables);
    listTables.add(tables);
    listTables.add(tables);
    //arrange
    when(() => repository.getTables())
        .thenAnswer((invocation) async => listTables);
    //act
    final result = await repository.getTables();
    //assert
    expect(result, listTables);
  });

  test('should return remote List<Customers> data when called', () async {
    List<Customers> listCustomers = [];
    Customers customers = const Customers(
        firstName: 'firstName',
        lastName: 'lastName',
        imageUrl: 'imageUrl',
        id: 1);

    listCustomers.add(customers);
    listCustomers.add(customers);
    listCustomers.add(customers);
    //arrange
    when(() => repository.getCustomers())
        .thenAnswer((invocation) async => listCustomers);
    //act
    final result = await repository.getCustomers();
    //assert
    expect(result, listCustomers);
  });

  test('should return remote data when the call is sucessfull', () async {
    List<Reservation> listReservations = [];
    Reservation tables = const Reservation(userId: 1, tableId: 1, id: 1);

    listReservations.add(tables);
    listReservations.add(tables);
    listReservations.add(tables);
    //arrange
    when(() => repository.getReservations())
        .thenAnswer((invocation) async => listReservations);
    //act
    final result = await repository.getReservations();
    //assert
    expect(result, listReservations);
  });
}
