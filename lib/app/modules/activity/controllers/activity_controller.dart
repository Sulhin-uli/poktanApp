import 'package:flutter/material.dart';
import 'package:poktan_app/app/data/models/activity_category_model.dart';
import 'package:poktan_app/app/data/models/activity_model.dart';
import 'package:poktan_app/app/data/models/user_model.dart';
import 'package:poktan_app/app/data/providers/activity_provider.dart';
import 'package:poktan_app/app/utils/base_url.dart';
import 'package:poktan_app/app/utils/constant.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ActivityController extends GetxController {
  final box = GetStorage();
  // list education
  var activity = List<Activity>.empty().obs;
  String selectedDate = "";

  // form
  late TextEditingController categoryActivityId;
  late TextEditingController title;
  late TextEditingController date;
  late TextEditingController desc;

  @override
  void onInit() {
    getData();

    // form
    categoryActivityId = TextEditingController();
    title = TextEditingController();
    date = TextEditingController();
    desc = TextEditingController();
    super.onInit();
  }

  void dialogQuestion(String title, String msg, BuildContext context, int id) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(msg),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Batal'),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'Ya');
              delete(id);
            },
            child: const Text('Ya'),
          ),
        ],
      ),
    );
  }

  // get data
  Future getData() async {
    final data = box.read("userData") as Map<String, dynamic>;
    return ActivityProvider().getData(data["token"]).then((response) {
      try {
        response["data"].map((e) {
          final data = Activity(
            id: e["id"],
            userId: User(
              id: e["user_id"]["id"],
              name: e["user_id"]["name"],
            ),
            categoryActivityId: ActivityCategory(
              id: e["category_activity_id"]["id"],
              name: e["category_activity_id"]["name"],
              createdAt: e["category_activity_id"]["created_at"],
              updatedAt: e["category_activity_id"]["updated_at"],
            ),
            title: e["title"],
            slug: e["slug"],
            date: e["date"],
            desc: e["desc"],
            createdAt: e["created_at"],
            updatedAt: e["updated_at"],
          );
          activity.add(data);
        }).toList();
      } catch (e) {
        // Get.toNamed(Routes.ERROR, arguments: e.toString());
        print("Error is : " + e.toString());
      }
    });
  }

  // add data
  void postData(
    int categoryActivityId,
    String title,
    String date,
    String desc,
  ) async {
    final data = box.read("userData") as Map<String, dynamic>;
    if (title != '' && date != '' && desc != '') {
      ActivityProvider()
          .postData(
              data["id"], categoryActivityId, title, date, desc, data["token"])
          .then((response) {
        // print(response);
        final data = Activity(
          id: response["data"]["id"],
          userId: User(
            id: response["data"]["user_id"]["id"],
            name: response["data"]["user_id"]["name"],
          ),
          categoryActivityId: ActivityCategory(
            id: response["data"]["category_activity_id"]["id"],
            name: response["data"]["category_activity_id"]["name"],
            createdAt: response["data"]["category_activity_id"]["created_at"],
            updatedAt: response["data"]["category_activity_id"]["updated_at"],
          ),
          title: response["data"]["title"],
          slug: response["data"]["slug"],
          date: response["data"]["date"],
          desc: response["data"]["desc"],
          createdAt: response["data"]["created_at"],
          updatedAt: response["data"]["updated_at"],
        );
        activity.insert(0, data);
        // print(response);
        Get.back();
        dialog("Berhasil !", "data berhasil ditambahkan!");
      });
    } else {
      dialog("Terjadi Kesalahan", "Semua Input Harus Diisi");
    }
  }

  // cari berdasarka id
  Activity findByid(int id) {
    return activity.firstWhere((element) => element.id == id);
  }

  void updateData(
    int id,
    int categoryActivityId,
    String title,
    String date,
    String desc,
  ) {
    final data = box.read("userData") as Map<String, dynamic>;
    final item = findByid(id);
    ActivityProvider()
        .updateData(id, categoryActivityId, title, date, desc, data["token"])
        .then((e) {
      item.categoryActivityId!.id = categoryActivityId;
      item.title = title;
      item.date = date;
      item.desc = desc;
      activity.refresh();
      Get.back();
      dialog("Berhasil !", "data berhasil diubah!");
    });
  }

  void delete(int id) {
    final data = box.read("userData") as Map<String, dynamic>;
    ActivityProvider()
        .deleteData(id, data["token"])
        .then((_) => activity.removeWhere((element) => element.id == id));
    dialog("Berhasil !", "data berhasil dihapus!");
  }
}
