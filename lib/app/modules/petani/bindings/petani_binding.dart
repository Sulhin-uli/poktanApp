import 'package:get/get.dart';

import '../controllers/petani_controller.dart';

class PetaniBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PetaniController>(
      () => PetaniController(),
    );
  }
}
