import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mobile_engineer/app/data/restaurante_repository_I.dart';
import 'package:flutter_mobile_engineer/app/modules/tables/models/customers.dart';
import 'package:flutter_mobile_engineer/app/modules/tables/models/reservations.dart';
import 'package:flutter_mobile_engineer/app/modules/tables/models/tables.dart';
import 'package:flutter_mobile_engineer/app/routes/app_pages.dart';
import 'package:flutter_mobile_engineer/app/utils/check_internet.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../views/widget/dialog_no_connection.dart';

class TablesController extends GetxController {
  final IRestaurantRepository repository;

  TablesController(this.repository);

  String TABLES_REMOTE = 'TABLES_DATA';
  String RESERVATION_REMOTE = 'RESERVATION_REMOTE';
  String CUSTOMERES_REMOTE = 'CUSTOMERES_REMOTE';
  late SharedPreferences sharedPreferences;
  var listTables = RxList<Tables>();
  var listReservations = RxList<Reservation>();
  var listCustomers = RxList<Customers>();

  var isLoading = RxBool(true);
  var hasData = RxBool(true);

  @override
  void onInit() {
    super.onInit();
    feachtData();
  }

  Future feachtData() async {
    isLoading.value = true;
    hasData.value = true;
    sharedPreferences = await SharedPreferences.getInstance();

    getTablesRemote();
    getReservationsRemote();
    getCustomersRemote();

    if (listTables.isNotEmpty) {
      hasData.value = true;
      isLoading.value = false;
      return;
    }
    if (!await isConnected()) {
      hasData.value = false;
      isLoading.value = false;

      update();
      showDialog(
          context: Get.context!,
          builder: (_) {
            return const DialogNoConnection(
              key: Key('No_internet_connection_dialog_is_visible'),
            );
          });

      return;
    }

    await getTables;
    saveTables();
    await getCustomers;
    saveCustomers();
    await getReservations;
    saveReservations();
    isLoading.value = false;
    update();
  }

  get getTables async => listTables.value = await repository.getTables();
  get getReservations async =>
      listReservations.value = await repository.getReservations();
  get getCustomers async =>
      listCustomers.value = await repository.getCustomers();

  Future<bool> isConnected() async => CheckInternetConection().isConnected();

  Customers? hasCustomers(int tableId) {
    Reservation? reservation = listReservations
        .firstWhereOrNull((element) => element.tableId == tableId);
    Customers? customers;
    if (reservation != null) {
      return listCustomers
          .firstWhereOrNull((element) => element.id == reservation.userId);
    }
    return customers;
  }

  void onTap({required Tables tables, required Customers? customers, required int index}) {

    if (customers != null) {
      showDialog(
          context: Get.context!,
          builder: (_) {
            return AlertDialog(
              content: const Text('Cancel Reservation?'),
              actions: [
                TextButton(
                    onPressed: () {
                      listReservations.removeWhere((element) => element.tableId==tables.id);
                      listTables.sort((a,b)=>a.id.compareTo(b.id));
                      saveReservations();
                      Get.back();
                    },
                    child: const Text('Cancel'))
              ],
            );
          });
    } else {
      Get.toNamed(Routes.CUSTOMERS, arguments: tables);
    }
  }

  Future saveCustomers() async {
    List<String> usrList =
        listCustomers.map((item) => jsonEncode(item.toJson())).toList();
    await sharedPreferences.setStringList(CUSTOMERES_REMOTE, usrList);
  }

  Future saveTables() async {
    List<String> usrList =
        listTables.map((item) => jsonEncode(item.toJson())).toList();
    await sharedPreferences.setStringList(TABLES_REMOTE, usrList);
  }

  Future saveReservations() async {
    List<String> usrList =
        listReservations.map((item) => jsonEncode(item.toJson())).toList();
    await sharedPreferences.setStringList(RESERVATION_REMOTE, usrList);
  }

  void getTablesRemote() {
    List<String>? listString = sharedPreferences.getStringList(TABLES_REMOTE);
    if (listString != null) {
      listTables.value =
          List<Tables>.from(listString.map((x) => tableFromJson(x)));
    }
  }

  void getReservationsRemote() {
    List<String>? listString =
        sharedPreferences.getStringList(RESERVATION_REMOTE);
    if (listString != null) {
      listReservations.value =
          List<Reservation>.from(listString.map((x) => reservationFromJson(x)));
    }
  }

  void getCustomersRemote() {
    List<String>? listString =
        sharedPreferences.getStringList(CUSTOMERES_REMOTE);
    if (listString != null) {
      listCustomers.value =
          List<Customers>.from(listString.map((x) => customersFromJson(x)));
    }
  }
}
