import 'package:get/get.dart';

import '../controllers/update_income_controller.dart';

class UpdateIncomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateIncomeController>(
      () => UpdateIncomeController(),
    );
  }
}
