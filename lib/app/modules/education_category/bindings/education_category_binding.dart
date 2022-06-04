import 'package:get/get.dart';

import '../controllers/education_category_controller.dart';

class EducationCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EducationCategoryController>(
      () => EducationCategoryController(),
    );
  }
}
