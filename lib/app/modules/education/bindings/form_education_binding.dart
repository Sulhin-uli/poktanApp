import 'package:poktan_app/app/modules/education/controllers/form_education_controller.dart';
import 'package:poktan_app/app/modules/education_category/controllers/education_category_controller.dart';
import 'package:get/get.dart';

class FormEducationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FormEducationController>(
      () => FormEducationController(),
    );
    Get.lazyPut<EducationCategoryController>(
      () => EducationCategoryController(),
    );
  }
}
