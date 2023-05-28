import 'package:flutter_mobile_engineer/app/modules/tables/models/customers.dart';
import 'package:flutter_mobile_engineer/app/modules/tables/models/reservations.dart';
import 'package:flutter_mobile_engineer/app/modules/tables/models/tables.dart';

abstract class IRestaurantRepository {
  Future<List<Tables>> getTables();
  Future<List<Customers>> getCustomers();
  Future<List<Reservation>> getReservations();
}
