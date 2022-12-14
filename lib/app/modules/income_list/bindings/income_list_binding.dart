import 'package:get/get.dart';

import '../controllers/income_list_controller.dart';

class IncomeListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IncomeListController>(
      () => IncomeListController(),
    );
  }
}
