import 'package:get/get.dart';

import '../controllers/mutasi_controller.dart';

class MutasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MutasiController>(
      () => MutasiController(),
    );
  }
}
