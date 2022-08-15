import 'package:get/get.dart';

import '../controllers/months_list_controller.dart';

class MonthsListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MonthsListController>(
      () => MonthsListController(),
    );
  }
}
