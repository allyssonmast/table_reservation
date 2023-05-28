import 'dart:convert';

import 'package:flutter_mobile_engineer/app/data/restaurante_repository_I.dart';
import 'package:flutter_mobile_engineer/app/modules/tables/models/customers.dart';
import 'package:flutter_mobile_engineer/app/modules/tables/models/reservations.dart';
import 'package:flutter_mobile_engineer/app/modules/tables/models/tables.dart';
import 'package:http/http.dart';

class RestaurantRepository implements IRestaurantRepository {
  final Client client;
  final String BASE_URL = 'https://s3-eu-west-1.amazonaws.com/';
  RestaurantRepository(this.client);

  @override
  Future<List<Customers>> getCustomers() async {
    var response = await client
        .get(Uri.parse('$BASE_URL/quandoo-assessment/customers.json'));
    var body = json.decode(response.body);
    return List<Customers>.from(body.map((model) => Customers.fromJson(model)));
  }

  @override
  Future<List<Reservation>> getReservations() async {
    var response = await client
        .get(Uri.parse('$BASE_URL/quandoo-assessment/reservations.json'));
    var body = json.decode(response.body);
    return List<Reservation>.from(
        body.map((model) => Reservation.fromJson(model)));
  }

  @override
  Future<List<Tables>> getTables() async {
    var response =
        await client.get(Uri.parse('$BASE_URL/quandoo-assessment/tables.json'));
    var body = json.decode(response.body);
    return List<Tables>.from(body.map((model) => Tables.fromJson(model)));
  }
}
