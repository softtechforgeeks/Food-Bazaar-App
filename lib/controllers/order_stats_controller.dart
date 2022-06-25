import 'package:flutter_login_ui/services/database_service.dart';
import 'package:get/get.dart';

import '../models/order_stat_model.dart';
import '../models/order_model.dart';

class OrderStatsController extends GetxController {
  final DatabaseService database = DatabaseService();

  var stats = Future.value(<OrderStats>[]).obs;

  @override
  void onInit() {
    super.onInit();
    stats.value = database.getOrderStats();
  }
}
