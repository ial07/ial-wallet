import 'package:get/get.dart';

import '../controllers/day_month_controller.dart';

class DayMonthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DayMonthController>(
      () => DayMonthController(),
    );
  }
}
