import 'package:poktan_app/app/modules/login/controllers/login_controller.dart';
import 'package:poktan_app/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthcontrollerController extends GetxController {
  final box = GetStorage();
  LoginController loginController = Get.put(LoginController());

  void dialogError(String msg) {
    Get.defaultDialog(title: "Terjadi Kesalahan", middleText: msg);
  }

  @override
  void onInit() {
    autoLogin();
    super.onInit();
  }

  Future<void> autoLogin() async {
    if (box.read("userData") != null) {
      final data = box.read("userData") as Map<String, dynamic>;
      loginController.login(data["email"], data["password"]);
    } else {
      Future.delayed(const Duration(milliseconds: 500), () {
        Get.offAllNamed(Routes.LOGIN);
      });
    }
  }
}
