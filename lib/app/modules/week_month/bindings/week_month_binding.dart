import 'package:get/get.dart';

import '../controllers/week_month_controller.dart';

class WeekMonthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WeekMonthController>(
      () => WeekMonthController(),
    );
  }
}
