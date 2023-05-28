import 'package:flutter/material.dart';
import 'package:flutter_mobile_engineer/app/modules/tables/models/customers.dart';
import 'package:flutter_mobile_engineer/app/modules/tables/models/tables.dart';

class TableAdapter extends StatelessWidget {
  final Tables tables;
  final Customers? customers;
  final Function(Tables, Customers?) onTap;
  const TableAdapter(
      {Key? key, required this.tables, this.customers, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: customers != null ? Colors.red : Colors.green,
      child: InkWell(
        onTap: () => onTap(tables, customers),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Table Id',
              style: TextStyle(fontSize: 24),
            ),
            Text(tables.id.toString()),
            const SizedBox(
              height: 8,
            ),
            if (customers != null)
              Card(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                  leading: CircleAvatar(
                    key: const Key('customer_image'),
                    backgroundImage: NetworkImage(customers!.imageUrl),
                    onBackgroundImageError: (_,__)=>Container(),
                  ),
                  title: Text('${customers!.firstName} ${customers!.lastName}',key: const Key('customer_name'),),
                ),
              )
            else
              const Text('Free')
          ],
        ),
      ),
    );
  }
}
