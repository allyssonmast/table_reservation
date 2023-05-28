import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogNoConnection extends StatelessWidget {
  const DialogNoConnection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Text('No internet conection'),
      actions: [
        TextButton(onPressed: Get.back, child: const Text('close app'))
      ],
    );
  }
}
