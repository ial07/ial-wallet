import 'package:get/get.dart';

import '../controllers/days_all_controller.dart';

class DaysAllBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DaysAllController>(
      () => DaysAllController(),
    );
  }
}
