import 'package:get/get.dart';

import '../controllers/days_frequency_controller.dart';

class DaysFrequencyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DaysFrequencyController>(
      () => DaysFrequencyController(),
    );
  }
}
