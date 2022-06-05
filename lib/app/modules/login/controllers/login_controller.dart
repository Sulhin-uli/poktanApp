import 'package:flutter/material.dart';
import 'package:poktan_app/app/data/models/gapoktan_model.dart';
import 'package:poktan_app/app/data/models/poktan_model.dart';
import 'package:poktan_app/app/data/models/user_model.dart';
import 'package:poktan_app/app/data/providers/login_provider.dart';
import 'package:poktan_app/app/data/providers/poktan_provider.dart';
import 'package:poktan_app/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final box = GetStorage();
  var isAuth = false.obs;
  var poktan = List<Poktan>.empty().obs;
  late TextEditingController email;
  late TextEditingController password;
  var hiddenTextPassword = true.obs;

  void dialogError(String msg) {
    Get.defaultDialog(title: "Terjadi Kesalahan", middleText: msg);
  }

  @override
  void onInit() {
    super.onInit();
    email = TextEditingController();
    password = TextEditingController();
  }

  void login(String email, String password) async {
    LoginProvider().login(email, password).then(
      (response) {
        if (email != '' && password != '') {
          if (response['success'] == true) {
            box.write('userData', {
              "id": response['data']['id'],
              "token": response['data']['token'],
              "email": email,
              "password": password
            });
            box.write('isAuth', true);
            getDataPoktan();
            Get.offAllNamed(Routes.HOME);
          } else {
            Get.offAllNamed(Routes.LOGIN);
            dialogError('Akun tidak ditemukan');
          }
        } else {
          dialogError('Semua data input harus di isi');
        }
      },
    );
  }

  void getDataPoktan() async {
    final data = box.read("userData") as Map<String, dynamic>;
    PoktanProvider().getData(data["token"]).then((response) {
      try {
        response["data"].map((e) {
          final data = Poktan(
            id: e["id"],
            userId: User(
              id: e["user_id"]["id"],
              name: e["user_id"]["name"],
            ),
            gapoktanId: Gapoktan(
              id: e["user_id"]["id"],
              userId: User(
                id: e["user_id"]["id"],
                name: e["user_id"]["name"],
              ),
            ),
            chairman: e["chairman"],
            city: e["city"],
            address: e["address"],
            telp: e["telp"].toString(),
            image: e["image"],
          );
          poktan.add(data);
        }).toList();
        final data = box.read("userData") as Map<String, dynamic>;
        box.write('userData', {
          "id": data['id'],
          "token": data["token"],
          "email": data["email"],
          "password": data["password"],
          "poktan_id": findPoktan(data["id"]).id,
        });
      } catch (e) {
        print("Error is : " + e.toString());
      }
    });
  }

  Poktan findPoktan(int id) {
    return poktan.firstWhere((e) => e.userId!.id! == id);
  }
}
