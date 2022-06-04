import 'package:poktan_app/app/modules/activity/controllers/activity_controller.dart';
import 'package:poktan_app/app/modules/activity/controllers/form_activity_controller.dart';
import 'package:get/get.dart';

class FormActivityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FormActivityController>(
      () => FormActivityController(),
    );
    Get.lazyPut<ActivityController>(
      () => ActivityController(),
    );
  }
}
