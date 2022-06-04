import 'dart:io';
import 'package:better_player/better_player.dart';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:poktan_app/app/data/models/education_category_model.dart';
import 'package:poktan_app/app/modules/education/controllers/education_controller.dart';
import 'package:poktan_app/app/utils/base_url.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AddEducationView extends GetView<EducationController> {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Tambah Edukasi',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        elevation: 0.5,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Kategori Edukasi",
                style: TextStyle(
                  color: Color(0xff919A92),
                ),
              ),
              const SizedBox(
                height: 9,
              ),
              Container(
                // padding: EdgeInsets.all(16),
                child: DropdownSearch<EducationCategory>(
                  showSearchBox: true,
                  popupItemBuilder: (context, item, isSelected) => ListTile(
                    title: Text("${item.name}"),
                  ),
                  dropdownSearchDecoration: const InputDecoration(
                    labelText: "",
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff919A92),
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff16A085),
                      ),
                    ),
                    // border: border,
                  ),
                  onFind: (text) async {
                    final data = box.read("userData") as Map<String, dynamic>;
                    var token = data["token"];
                    Dio dio = Dio();

                    dio.options.headers['content-Type'] = 'application/json';
                    dio.options.headers["authorization"] =
                        "Bearer ${data["token"]}";
                    var response =
                        await dio.get(baseUrl + "education-category");
                    return EducationCategory.fromJsonList(
                        response.data["data"]);
                  },
                  // onChanged: (value) => print(value?.toJson()["kota"]),
                  onChanged: (e) {
                    controller.category_education_id.text =
                        e!.toJson()["id"].toString();
                    // print(e!.toJson()["id"]);
                  },
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Judul",
                style: TextStyle(
                  color: Color(0xff919A92),
                ),
              ),
              TextFormField(
                controller: controller.title,
                cursorColor: const Color(0xff16A085),
                decoration: const InputDecoration(
                  helperText: 'Contoh: Label',
                  // fillColor: Color(0xff919A92),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff919A92),
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff16A085),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "File",
                style: TextStyle(
                  color: Color(0xff919A92),
                ),
              ),
              InkWell(
                onTap: () => controller.dialogUploadFile(),
                child: Center(
                  child: DottedBorder(
                    color: Colors.green,
                    strokeWidth: 1,
                    dashPattern: const [5, 5],
                    child: Container(
                      height: 80,
                      width: 140,
                      color: Colors.green[50],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.drive_folder_upload,
                            color: Colors.green,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Pilih file disini ...",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              const SizedBox(height: 30),
              Obx(
                () => controller.selectedImagePath.value != ''
                    ? Obx(
                        () => controller.selectedImagePath.value.isImageFileName
                            ? Center(
                                child: SizedBox(
                                  height: 300,
                                  width: 300,
                                  child: Image.file(
                                    File(controller.selectedImagePath.value),
                                  ),
                                ),
                              )
                            : Hero(
                                tag: "data.slug!",
                                child: AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: BetterPlayer.file(
                                    controller.selectedImagePath.value,
                                    betterPlayerConfiguration:
                                        const BetterPlayerConfiguration(
                                      aspectRatio: 16 / 9,
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                              ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("No File selected."),
                        ],
                      ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Deskripsi",
                style: TextStyle(
                  color: Color(0xff919A92),
                ),
              ),
              const SizedBox(
                height: 9,
              ),
              TextFormField(
                maxLines: 5,
                controller: controller.desc,
                cursorColor: const Color(0xff16A085),
                decoration: InputDecoration(
                  // helperText: 'Contoh: Label',
                  // fillColor: Color(0xff919A92),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff919A92),
                    ),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff16A085),
                    ),
                  ),
                  fillColor: Colors.grey[100],
                  filled: true,
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: SizedBox(
                  height: 46, //height of button
                  width: 300,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xff16A085), // background
                    ),
                    onPressed: () {
                      controller.isLoadingButton.value = false;
                      controller.postData(
                        int.parse(controller.category_education_id.text),
                        controller.title.text,
                        controller.selectedImagePath.value,
                        controller.desc.text,
                      );
                    },
                    child: Obx(
                      () => controller.isLoadingButton.isTrue
                          ? const Text('Tambah')
                          : const CircularProgressIndicator(
                              color: Colors.white,
                            ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
