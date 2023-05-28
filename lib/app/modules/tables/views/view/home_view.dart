import 'package:flutter/material.dart';
import 'package:flutter_mobile_engineer/app/modules/tables/models/customers.dart';
import 'package:flutter_mobile_engineer/app/modules/tables/models/tables.dart';
import 'package:flutter_mobile_engineer/app/modules/tables/views/widget/table_adapter.dart';

import 'package:get/get.dart';

import '../../controllers/tables_controller.dart';

class HomeView extends GetView<TablesController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('Screen_with_tables'),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Tables',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Obx(() => controller.isLoading.isTrue
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : controller.hasData.isFalse
              ? Center(
                  child: TextButton.icon(
                      onPressed: controller.feachtData,
                      icon: const Icon(Icons.update),
                      label: const Text('Try again')),
                )
              : GridView.builder(
                  key:const Key('List_of_tables_is_visible'),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: controller.listTables.length,
                  itemBuilder: (_, index) {
                    Tables tables = controller.listTables[index];
                    Customers? customers = controller.hasCustomers(tables.id);
                    return TableAdapter(
                      tables: tables,
                      customers: customers,
                      onTap: (table, customer) => controller.onTap(
                          tables: tables, customers: customers,index: index),
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      childAspectRatio: 1.2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      maxCrossAxisExtent: 240,
                      mainAxisExtent: 180),
                )),
    );
  }
}
