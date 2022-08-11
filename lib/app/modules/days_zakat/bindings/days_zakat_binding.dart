import 'package:get/get.dart';

import '../controllers/days_zakat_controller.dart';

class DaysZakatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DaysZakatController>(
      () => DaysZakatController(),
    );
  }
}
