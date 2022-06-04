import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:poktan_app/app/data/models/activity_category_model.dart';
import 'package:poktan_app/app/modules/activity/controllers/activity_controller.dart';
import 'package:poktan_app/app/utils/base_url.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class EditActivityView extends GetView<ActivityController> {
  final activityC = Get.find<ActivityController>();
  final box = GetStorage();

  // final educationCategoryC = Get.find<EducationCategoryController>();

  @override
  Widget build(BuildContext context) {
    final data = controller.findByid(Get.arguments);
    // controller.category_education_id.text = data.categoryEducationId.toString();
    // print(data.categoryEducationId.toString());
    controller.categoryActivityId.text = data.categoryActivityId!.id.toString();
    controller.title.text = data.title!;
    String formattedDate =
        DateFormat('yyyy-MM-dd').format(DateTime.tryParse(data.date!));
    controller.date.text = formattedDate;
    controller.desc.text = data.desc!;
    // educationCategoryC.changeEditCategory(data.categoryEducationId!);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Ubah Kegiatan',
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
                "Kategori Kegiatan",
                style: TextStyle(
                  color: Color(0xff919A92),
                ),
              ),
              const SizedBox(
                height: 9,
              ),
              Container(
                // padding: EdgeInsets.all(16),
                child: DropdownSearch<ActivityCategory>(
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
                    var response = await dio.get(baseUrl + "activity-category");
                    return ActivityCategory.fromJsonList(response.data["data"]);
                  },
                  // onChanged: (value) => print(value?.toJson()["kota"]),
                  onChanged: (e) {
                    controller.categoryActivityId.text =
                        e!.toJson()["id"].toString();
                    // print(e!.toJson()["id"]);
                  },
                  selectedItem: data.categoryActivityId!,
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
                  // helperText: 'Contoh: Label',
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
                "Tanggal",
                style: TextStyle(
                  color: Color(0xff919A92),
                ),
              ),
              TextFormField(
                controller: controller.date,
                readOnly: true,
                cursorColor: const Color(0xff16A085),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101));

                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    controller.date.text = formattedDate;
                  } else {
                    print("Date is not selected");
                  }
                },
                decoration: const InputDecoration(
                  // helperText: 'Contoh: Label',
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
                  suffixIcon: Icon(
                    Icons.date_range_rounded,
                    color: Color(0xff919A92),
                  ),
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
                    onPressed: () => activityC.updateData(
                      Get.arguments,
                      int.parse(controller.categoryActivityId.text),
                      controller.title.text,
                      controller.date.text,
                      controller.desc.text,
                    ),
                    child: const Text('Ubah'),
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
