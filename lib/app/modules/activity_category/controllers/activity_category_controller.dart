import 'package:flutter/material.dart';
import 'package:poktan_app/app/data/models/activity_category_model.dart';
import 'package:poktan_app/app/data/providers/activity_category_provider.dart';
import 'package:poktan_app/app/utils/base_url.dart';
import 'package:poktan_app/app/utils/constant.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ActivityCategoryController extends GetxController {
  final box = GetStorage();
  late TextEditingController name;
  var hiddenTextPassword = true.obs;
  var activityCategory = List<ActivityCategory>.empty().obs;

  @override
  void onInit() {
    name = TextEditingController();
    getData();
    super.onInit();
  }

  // add data
  void postData(
    String name,
  ) async {
    final data = box.read("userData") as Map<String, dynamic>;
    if (name != '') {
      ActivityCategoryProvider().postData(name, data["token"]).then((response) {
        // print(response);
        final data = ActivityCategory(
          id: response["data"]["id"],
          name: response["data"]["name"],
          createdAt: response["data"]["created_at"],
          updatedAt: response["data"]["updated_at"],
        );
        activityCategory.add(data);
        Get.back();
        dialog("Berhasil !", "data berhasil ditambahkan!");
      });
    } else {
      dialog("Terjadi Kesalahan", "Semua Input Harus Diisi");
    }
  }

  void getData() async {
    final data = box.read("userData") as Map<String, dynamic>;

    ActivityCategoryProvider().getData(data["token"]).then((response) {
      try {
        response["data"].map((e) {
          final data = ActivityCategory(
            id: e["id"],
            name: e["name"],
            createdAt: e["created_at"],
            updatedAt: e["updated_at"],
          );
          activityCategory.add(data);
        }).toList();
      } catch (e) {
        print("Error is : " + e.toString());
      }
    });
  }

  ActivityCategory findByid(int id) {
    return activityCategory.firstWhere((element) => element.id == id);
  }

  void editData(
    int id,
    String name,
  ) {
    final item = findByid(id);
    final data = box.read("userData") as Map<String, dynamic>;
    ActivityCategoryProvider().updateData(id, name, data["token"]).then((_) {
      item.name = name;
      activityCategory.refresh();
      Get.back();
      dialog("Berhasil !", "data berhasil diubah");
    });
  }

  void deleteData(int id) {
    final data = box.read("userData") as Map<String, dynamic>;
    ActivityCategoryProvider().deleteData(id, data["token"]).then(
        (_) => activityCategory.removeWhere((element) => element.id == id));
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
            },
            child: const Text('Ya'),
          ),
        ],
      ),
    );
  }
}
