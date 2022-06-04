import 'dart:io';
import 'package:flutter/material.dart';
import 'package:poktan_app/app/data/providers/gapoktan_provider.dart';
import 'package:poktan_app/app/data/providers/poktan_provider.dart';
import 'package:poktan_app/app/data/providers/user_provider.dart';
import 'package:poktan_app/app/utils/base_url.dart';
import 'package:poktan_app/app/utils/constant.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class SayaController extends GetxController {
  final box = GetStorage();
  late TextEditingController chairman;
  late TextEditingController city;
  late TextEditingController address;
  late TextEditingController telp;
  late TextEditingController passwordCurrent;
  late TextEditingController passwordNew;
  late TextEditingController passwordConfirm;
  var hiddenTextPasswordCurrent = true.obs;
  var hiddenTextPasswordNew = true.obs;
  var hiddenTextPasswordConfirm = true.obs;
  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;

  @override
  void onInit() {
    chairman = TextEditingController();
    city = TextEditingController();
    address = TextEditingController();
    telp = TextEditingController();
    passwordCurrent = TextEditingController();
    passwordNew = TextEditingController();
    passwordConfirm = TextEditingController();
    super.onInit();
  }

  void getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      selectedImageSize.value = " Mb";
      updateImage(selectedImagePath.value);
    } else {
      Get.snackbar(
        "Warning",
        "No image Selected",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void updateImage(
    String image,
  ) {
    final data = box.read("userData") as Map<String, dynamic>;
    Map<String, String> body = {"id": data["gapoktan_id"].toString()};
    GapoktanProvider().updateImage(body, image, data["token"]).then((response) {
      print(response);
    });
  }

  void editData(
    String chairman,
    String city,
    String address,
    String telp,
  ) {
    final data = box.read("userData") as Map<String, dynamic>;
    GapoktanProvider()
        .updateData(
            data["gapoktan_id"], chairman, city, address, telp, data["token"])
        .then((_) {
      dialog("Berhasil !", "data berhasil diubah");
      Get.back();
    });
  }

  void editPassword(
    String passwordCurrent,
    String passwordNew,
    String passwordConfirm,
  ) {
    final data = box.read("userData") as Map<String, dynamic>;
    if (passwordCurrent != '' && passwordNew != '' && passwordConfirm != '') {
      if (passwordCurrent != data["password"]) {
        dialogNoBack("Terjadi Kesalahan !", "Password saat ini salah");
      } else {
        if (passwordNew == passwordConfirm) {
          final data = box.read("userData") as Map<String, dynamic>;
          UserProvider()
              .updateData(data["id"], passwordNew, data["token"])
              .then((response) {
            final data = box.read("userData") as Map<String, dynamic>;
            box.write('userData', {
              "id": data['id'],
              "token": data["token"],
              "email": data["email"],
              "password": passwordNew,
              "gapoktan_id": data["gapoktan_id"],
            });
            Get.back();
            dialog("Berhasil !", "data berhasil diubah");
          });
        } else {
          dialogNoBack("Terjadi Kesalahan !", "Konfirmasi password tidak sama");
        }
      }
    } else {
      dialogNoBack("Terjadi Kesalahan", "Semua Input Harus Diisi");
    }
  }
}
