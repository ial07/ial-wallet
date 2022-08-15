import 'package:get/get.dart';

import '../controllers/weeks_list_controller.dart';

class WeeksListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WeeksListController>(
      () => WeeksListController(),
    );
  }
}
