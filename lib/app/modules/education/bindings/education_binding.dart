import 'package:poktan_app/app/modules/education_category/controllers/education_category_controller.dart';
import 'package:get/get.dart';

import '../controllers/education_controller.dart';

class EducationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EducationController>(
      () => EducationController(),
    );
    Get.lazyPut<EducationCategoryController>(
      () => EducationCategoryController(),
    );
  }
}
