import 'package:get/get.dart';

import '../controllers/expenses_controller.dart';

class ExpensesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExpensesController>(
      () => ExpensesController(),
    );
  }
}
