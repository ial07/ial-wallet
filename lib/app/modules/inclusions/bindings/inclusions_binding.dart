import 'package:get/get.dart';

import '../controllers/inclusions_controller.dart';

class InclusionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InclusionsController>(
      () => InclusionsController(),
    );
  }
}
