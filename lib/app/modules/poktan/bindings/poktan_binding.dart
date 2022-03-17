import 'package:get/get.dart';

import '../controllers/poktan_controller.dart';

class PoktanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PoktanController>(
      () => PoktanController(),
    );
  }
}
