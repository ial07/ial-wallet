import 'package:get/get.dart';

import '../controllers/directed_controller.dart';

class DirectedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DirectedController>(
      () => DirectedController(),
    );
  }
}
