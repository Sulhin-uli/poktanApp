import 'dart:io';
import 'package:flutter/material.dart';
import 'package:poktan_app/app/data/models/education_category_model.dart';
import 'package:poktan_app/app/data/models/education_model.dart';
import 'package:poktan_app/app/data/models/user_model.dart';
import 'package:poktan_app/app/data/providers/education_provider.dart';
import 'package:poktan_app/app/utils/base_url.dart';
import 'package:poktan_app/app/utils/constant.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class EducationController extends GetxController {
  final box = GetStorage();
  var education = List<Education>.empty().obs;
  late TextEditingController category_education_id;
  late TextEditingController title;
  late TextEditingController desc;
  String? thumbnail;
  var isLoadingButton = true.obs;

  // upload image
  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;

  // old
  var isUpload = false.obs;

  @override
  void onInit() {
    super.onInit();
    category_education_id = TextEditingController();
    title = TextEditingController();
    desc = TextEditingController();
    getData();
    // getTumbnail();
  }

  // add data
  void postData(
    int categoryEducationId,
    String title,
    String file,
    String desc,
  ) async {
    final data = box.read("userData") as Map<String, dynamic>;
    if (categoryEducationId != '' && file != '' && title != '' && desc != '') {
      try {
        Map<String, String> body = {
          "user_id": data["id"].toString(),
          "category_education_id": categoryEducationId.toString(),
          "title": title,
          "desc": desc,
        };
        EducationProvider()
            .postData(body, file, data["token"])
            .then((response) {
          // print(response["data"]["id"]);
          final data = Education(
            id: response["data"]["id"],
            userId: User(
              id: response["data"]["user_id"]["id"],
              name: response["data"]["user_id"]["name"],
            ),
            categoryEducationId: EducationCategory(
              id: response["data"]["category_education_id"]["id"],
              name: response["data"]["category_education_id"]["name"],
              createdAt: response["data"]["category_education_id"]
                  ["created_at"],
              updatedAt: response["data"]["category_education_id"]
                  ["updated_at"],
            ),
            title: response["data"]["title"],
            slug: response["data"]["slug"],
            date: response["data"]["date"],
            file: response["data"]["file"],
            desc: response["data"]["desc"],
            createdAt: response["data"]["created_at"],
            updatedAt: response["data"]["updated_at"],
          );
          education.insert(0, data);
          education.clear();
          getData();
          Get.back();
          dialog("Berhasil !", "data berhasil ditambahkan!");
          isLoadingButton.value = true;
        });
      } catch (e) {
        dialog("Terjadi Kesalahan", "data gagal ditambahkan");

        print("error is $e");
      }
    } else {
      dialog("Terjadi Kesalahan", "Semua Input Harus Diisi");
    }
  }

  // dialog upload File
  void dialogUploadFile() {
    Get.defaultDialog(
      title: "Pilih file",
      content: Container(
        child: Column(
          children: [
            ListTile(
              onTap: () {
                getImage(ImageSource.gallery);
                Get.back();
              },
              leading: const Icon(Icons.image),
              title: const Text("Gambar"),
            ),
            ListTile(
              onTap: () {
                getVideo(ImageSource.gallery);
                Get.back();
              },
              leading: const Icon(Icons.video_library),
              title: const Text("Video"),
            ),
          ],
        ),
      ),
    );
  }

  // get data
  Future getData() async {
    final data = box.read("userData") as Map<String, dynamic>;
    return EducationProvider().getData(data["token"]).then((response) {
      try {
        response["data"].map((e) {
          final data = Education(
            id: e["id"],
            userId: User(
              id: e["user_id"]["id"],
              name: e["user_id"]["name"],
            ),
            categoryEducationId: EducationCategory(
              id: e["category_education_id"]["id"],
              name: e["category_education_id"]["name"],
              createdAt: e["category_education_id"]["created_at"],
              updatedAt: e["category_education_id"]["updated_at"],
            ),
            title: e["title"],
            slug: e["slug"],
            date: e["date"],
            file: e["file"],
            desc: e["desc"],
            createdAt: e["created_at"],
            updatedAt: e["updated_at"],
          );
          education.add(data);
        }).toList();
      } catch (e) {
        print("Error is : " + e.toString());
      }
    });
  }

  void getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      selectedImageSize.value =
          ((File(selectedImagePath.value)).lengthSync() / 1024 / 1024)
                  .toStringAsFixed(2) +
              " Mb";
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

  void getVideo(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickVideo(source: imageSource);

    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      selectedImageSize.value =
          ((File(selectedImagePath.value)).lengthSync() / 1024 / 1024)
                  .toStringAsFixed(2) +
              " Mb";
    } else {
      Get.snackbar(
        "Error",
        "No Video Selected",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // cari berdasarka id
  Education findByid(int id) {
    return education.firstWhere((element) => element.id == id);
  }

  void editData(
    int id,
    int categoryEducationId,
    String title,
    String file,
    String desc,
  ) {
    final item = findByid(id);
    final data = box.read("userData") as Map<String, dynamic>;

    if (file == '') {
      EducationProvider()
          .updateDataWOfile(
              id, data["id"], categoryEducationId, title, desc, data["token"])
          .then((response) {
        item.categoryEducationId!.id = categoryEducationId;
        item.title = title;
        item.desc = desc;
        education.refresh();
        Get.back();
        dialog("Berhasil !", "data berhasil diubah");
      });
    } else {
      Map<String, String> body = {
        "id": id.toString(),
        "user_id": data["id"].toString(),
        "category_education_id": categoryEducationId.toString(),
        "title": title,
        "desc": desc,
      };

      EducationProvider()
          .updateDataWfile(body, file, data["token"])
          .then((response) {
        education.clear();
        getData();
        Future.delayed(const Duration(seconds: 3), () {});
        Get.back();
        dialog("Berhasil !", "data berhasil ditambahkan!");
        isLoadingButton.value = true;
      });
    }
  }

  void deleteData(int id) {
    final data = box.read("userData") as Map<String, dynamic>;
    EducationProvider()
        .deleteData(id, data["token"])
        .then((_) => education.removeWhere((element) => element.id == id));
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
