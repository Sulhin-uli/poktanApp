import 'package:flutter/material.dart';
import 'package:poktan_app/app/data/models/education_category_model.dart';
import 'package:poktan_app/app/data/providers/education_category_provider.dart';
import 'package:poktan_app/app/utils/base_url.dart';
import 'package:poktan_app/app/utils/constant.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class EducationCategoryController extends GetxController {
  final box = GetStorage();
  // list education
  var education_category = List<EducationCategory>.empty().obs;
  // get name of category educatiom
  final getNameCategoryEducation = "".obs;
  // dropdown
  final selectedValue = "".obs;
  final selectedEditValue = "".obs;
  // loading
  var isLoading = true.obs;
  late TextEditingController name;

  void onSelected(String value) {
    selectedValue.value = value;
    // registrationParam.value.roleType = selectedRole.value;
  }

  @override
  void onInit() {
    getData();
    name = TextEditingController();
    super.onInit();
  }

  // add data
  void postData(
    String name,
  ) async {
    final data = box.read("userData") as Map<String, dynamic>;
    if (name != '') {
      EducationCategoryProvider()
          .postData(name, data["token"])
          .then((response) {
        final data = EducationCategory(
          id: response["data"]["id"],
          name: response["data"]["name"],
          slug: response["data"]["slug"],
          createdAt: response["data"]["created_at"],
          updatedAt: response["data"]["updated_at"],
        );
        education_category.add(data);
        Get.back();
        dialog("Berhasil !", "data berhasil ditambahkan!");
      });
    } else {
      dialog("Terjadi Kesalahan", "Semua Input Harus Diisi");
    }
  }

  void getData() async {
    final data = box.read("userData") as Map<String, dynamic>;
    EducationCategoryProvider().getData(data["token"]).then((response) {
      try {
        response["data"].map((e) {
          final data = EducationCategory(
            id: e["id"],
            name: e["name"],
            createdAt: e["created_at"],
            updatedAt: e["updated_at"],
          );
          education_category.add(data);
        }).toList();
      } catch (e) {
        print("Error is : " + e.toString());
      }
    });
  }

  EducationCategory findByid(int id) {
    return education_category.firstWhere((element) => element.id == id);
  }

  void editData(
    int id,
    String name,
  ) {
    final item = findByid(id);
    final data = box.read("userData") as Map<String, dynamic>;
    EducationCategoryProvider().updateData(id, name, data["token"]).then((_) {
      item.name = name;
      education_category.refresh();
      Get.back();
      dialog("Berhasil !", "data berhasil diubah");
    });
  }

  void deleteData(int id) {
    final data = box.read("userData") as Map<String, dynamic>;
    EducationCategoryProvider().deleteData(id, data["token"]).then(
        (_) => education_category.removeWhere((element) => element.id == id));
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

  // // get data
  // Future fetchData() async {
  //   return EducationCategoryProvider().fetchData().then((response) {
  //     for (var i = 0; i < response[0].length; i++) {
  //       final data = EducationCategory(
  //         id: response[0][i]["id"],
  //         name: response[0][i]["name"],
  //         createdAt: response[0][i]["created_at"],
  //         updatedAt: response[0][i]["updated_at"],
  //       );
  //       education_category.add(data);
  //     }
  //     selectedValue.value = education_category[0].id.toString();
  //     // selectedEditValue.value = education_category[0].id.toString();
  //   });
  // }

  // void changeEditCategory(int id) {
  //   selectedEditValue.value = findByid(id).id!.toString();
  // }

  Future getNameCategory(int id) async {
    var name = findByid(id).name;
    getNameCategoryEducation.value = name!;
  }

  // dropdown
  List<DropdownMenuItem<String>> addDividersAfterItems(List<String> items) {
    List<DropdownMenuItem<String>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          //If it's last item, we will not add Divider after it.
          if (item != items.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Divider(),
            ),
        ],
      );
    }
    return _menuItems;
  }

  List<int> getDividersIndexes() {
    List<int> _dividersIndexes = [];
    for (var i = 0; i < (education_category.length * 2) - 1; i++) {
      //Dividers indexes will be the odd indexes
      if (i.isOdd) {
        _dividersIndexes.add(i);
      }
    }
    return _dividersIndexes;
  }
}
