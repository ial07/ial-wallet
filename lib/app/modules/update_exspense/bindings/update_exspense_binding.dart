import 'package:get/get.dart';

import '../controllers/update_exspense_controller.dart';

class UpdateExspenseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateExspenseController>(
      () => UpdateExspenseController(),
    );
  }
}
