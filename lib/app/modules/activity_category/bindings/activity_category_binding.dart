import 'package:get/get.dart';

import '../controllers/activity_category_controller.dart';

class ActivityCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActivityCategoryController>(
      () => ActivityCategoryController(),
    );
  }
}
