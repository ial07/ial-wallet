import 'package:get/get.dart';

import '../controllers/days_daily_controller.dart';

class DaysDailyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DaysDailyController>(
      () => DaysDailyController(),
    );
  }
}
