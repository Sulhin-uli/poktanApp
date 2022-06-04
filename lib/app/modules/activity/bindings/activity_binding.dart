import 'package:poktan_app/app/modules/activity_category/controllers/activity_category_controller.dart';
import 'package:get/get.dart';

import '../controllers/activity_controller.dart';

class ActivityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActivityController>(
      () => ActivityController(),
    );
    Get.lazyPut<ActivityCategoryController>(
      () => ActivityCategoryController(),
    );
  }
}
