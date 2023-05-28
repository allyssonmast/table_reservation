import 'package:flutter_mobile_engineer/app/data/restaurant_repository.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import '../controllers/tables_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    var client = Client();
    var repository = RestaurantRepository(client);
    Get.lazyPut<TablesController>(() => TablesController(repository));
  }
}
