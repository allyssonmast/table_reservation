import 'package:flutter/material.dart';
import 'package:flutter_mobile_engineer/app/modules/tables/models/customers.dart';

import 'package:get/get.dart';

import '../controllers/customers_controller.dart';

class CustomersView extends GetView<CustomersController> {
  const CustomersView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('Screen_with_users_tables'),
      appBar: AppBar(
        elevation: 0,
        title: Text('Table ${controller.tables.id}'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: controller.listCustomer.length,
          itemBuilder: (_, index) {
            Customers customers = controller.listCustomer[index];
            return ListTile(
              onTap:()=> controller.onTapCustomer(customers),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(customers.imageUrl),
              ),
              title: Text('${customers.firstName} ${customers.lastName}'),
            );
          }),
    );
  }
}
