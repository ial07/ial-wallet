import 'package:get/get.dart';

import '../controllers/months_income_controller.dart';

class MonthsIncomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MonthsIncomeController>(
      () => MonthsIncomeController(),
    );
  }
}
