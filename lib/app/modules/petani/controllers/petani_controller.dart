import 'package:flutter/material.dart';
import 'package:poktan_app/app/data/models/farmer_model.dart';
import 'package:poktan_app/app/data/models/user_model.dart';
import 'package:poktan_app/app/data/providers/farmer_provider.dart';
import 'package:poktan_app/app/utils/base_url.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PetaniController extends GetxController {
  final box = GetStorage();
  var farmer = List<Farmer>.empty().obs;
  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController password2;
  var hiddenTextPassword = true.obs;
  var hiddenTextPassword2 = true.obs;

  @override
  void onInit() {
    getData();
    name = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    password2 = TextEditingController();
    super.onInit();
  }

  // add data
  void postData(
    String name,
    String email,
    String password,
    String password2,
  ) async {
    final data = box.read("userData") as Map<String, dynamic>;
    bool isActive = true;
    if (name != '') {
      if (password == password2) {
        try {
          FarmerProvider()
              .postData(name, email, password, data["poktan_id"], isActive,
                  data["token"])
              .then((response) {
            final data = Farmer(
              id: response["data"]["id"],
              userId: User(
                id: response["data"]["user_id"]["id"],
                name: response["data"]["user_id"]["name"],
                email: response["data"]["user_id"]["email"],
              ),
              city: response["data"]["city"],
            );
            farmer.insert(0, data);
            Get.back();
            dialog("Berhasil !", "data berhasil ditambahkan!");
          });
        } catch (e) {
          print("Error is : " + e.toString());
        }
      } else {
        dialog("Terjadi Kesalahan", "Konfirmasi password tidak sama");
      }
    } else {
      dialog("Terjadi Kesalahan", "Semua Input Harus Diisi");
    }
  }

  void getData() async {
    final data = box.read("userData") as Map<String, dynamic>;
    FarmerProvider().getData(data["token"]).then((response) {
      try {
        response["data"].map((e) {
          final data = Farmer(
            id: e["id"],
            userId: User(
              id: e["user_id"]["id"],
              name: e["user_id"]["name"],
              email: e["user_id"]["email"],
            ),
            city: e["city"],
          );
          farmer.add(data);
        }).toList();
      } catch (e) {
        print("error is :" + e.toString());
      }
    });
  }

  Farmer findByid(int id) {
    return farmer.firstWhere((element) => element.id == id);
  }

  void editData(
    int id,
    int userId,
    String name,
    String email,
    String? password,
    String? password2,
  ) {
    final item = findByid(id);
    final data = box.read("userData") as Map<String, dynamic>;
    bool isActive = true;
    FarmerProvider()
        .updateData(id, userId, name, email, password, data["poktan_id"], true,
            data["token"])
        .then((_) {
      item.userId!.name = name;
      item.userId!.email = email;
      farmer.refresh();
      Get.back();
      dialog("Berhasil !", "data berhasil diubah");
    });
  }

  void deleteData(int id) {
    final data = box.read("userData") as Map<String, dynamic>;
    FarmerProvider()
        .deleteData(id, data["token"])
        .then((_) => farmer.removeWhere((element) => element.userId!.id == id));
    // Get.back();
    dialog("Berhasil !", "data berhasil dihapus!");
  }

  void dialogQuestion(BuildContext context, int id) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Peringatan"),
        content: const Text("Yakin menghapus data?"),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Batal'),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'Ya');
              deleteData(id);
              // print(id);
            },
            child: const Text('Ya'),
          ),
        ],
      ),
    );
  }
}
