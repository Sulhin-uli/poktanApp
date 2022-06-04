import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:poktan_app/app/data/models/product_category_model.dart';
import 'package:poktan_app/app/modules/produk/controllers/produk_controller.dart';
import 'package:poktan_app/app/utils/base_url.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class EditProdukView extends GetView<ProdukController> {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    final data = controller.findByid(Get.arguments);
    controller.name.text = data.name!;
    controller.categoryProductId.text = data.categoryProductId!.id!.toString();
    // String formattedDate =
    //     DateFormat('yyyy-MM-dd').format(DateTime.tryParse(data.date!));
    // controller.date.text = formattedDate;
    controller.code.text = data.code!;
    controller.stoke.text = data.stoke!.toString();
    controller.price.text = data.price!.toString();
    controller.desc.text = data.desc!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context, true);
              controller.photoProductByProductId.clear();
            }),
        title: const Text(
          'Edit Produk',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        elevation: 0.5,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              const Text(
                "Nama Produk",
                style: TextStyle(
                  color: Color(0xff919A92),
                ),
              ),
              TextFormField(
                controller: controller.name,
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
                child: DropdownSearch<ProductCategory>(
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
                    var response = await dio.get(baseUrl + "product-category");
                    return ProductCategory.fromJsonList(response.data["data"]);
                  },
                  onChanged: (e) {
                    controller.categoryProductId.text =
                        e!.toJson()["id"].toString();
                    // print(e!.toJson()["id"]);
                  },
                  selectedItem: data.categoryProductId!,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Kode Produk",
                style: TextStyle(
                  color: Color(0xff919A92),
                ),
              ),
              TextFormField(
                controller: controller.stoke,
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
                "Stok Produk",
                style: TextStyle(
                  color: Color(0xff919A92),
                ),
              ),
              TextFormField(
                controller: controller.stoke,
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
                "Harga",
                style: TextStyle(
                  color: Color(0xff919A92),
                ),
              ),
              TextFormField(
                controller: controller.price,
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
              const Text(
                "Foto Produk",
                style: TextStyle(
                  color: Color(0xff919A92),
                ),
              ),
              Obx(
                () => controller.visibleEditPhoto.isTrue
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 200,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  controller.photoProductByProductId.length,
                              itemBuilder: (context, i) {
                                return Container(
                                  margin: const EdgeInsets.all(5),
                                  child: Image.network(
                                    baseUrlFile +
                                        "storage/produk/" +
                                        controller
                                            .photoProductByProductId[i].name!,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 26, //height of button
                            width: 150,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.grey, // background
                              ),
                              onPressed: () {
                                controller.visibleEditPhoto.value =
                                    !controller.visibleEditPhoto.value;
                              },
                              child: const Text('Bersihkan Foto'),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          InkWell(
                            // onTap: () => controller.dialogUploadFile(),
                            onTap: () => controller.getMultipleImage(),
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
                        ],
                      ),
              ),
              Obx(
                () => controller.selectedImagePath.isNotEmpty
                    ? SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.selectedImagePath.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.all(5),
                              child: Image.file(
                                File(controller.selectedImagePath[index].path),
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                      )
                    // : Container(),
                    : Obx(
                        () => controller.visibleEditPhoto.isTrue
                            ? Container()
                            : const Text("No image selected"),
                      ),
              ),
              const SizedBox(height: 5),
              Obx(
                () => controller.selectedImagePath.isNotEmpty
                    ? SizedBox(
                        height: 26, //height of button
                        width: 150,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.grey, // background
                          ),
                          onPressed: () {
                            controller.selectedImagePath.clear();
                          },
                          child: const Text('Bersihkan Foto'),
                        ),
                      )
                    : Container(),
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
                      if (controller.selectedImagePath.isNotEmpty) {
                        controller.updateDataWithPhoto(
                          Get.arguments,
                          controller.name.text,
                          int.parse(controller.categoryProductId.text),
                          controller.code.text,
                          int.parse(controller.stoke.text),
                          int.parse(controller.price.text),
                          controller.desc.text,
                        );
                      } else {
                        controller.updateData(
                          Get.arguments,
                          controller.name.text,
                          int.parse(controller.categoryProductId.text),
                          controller.code.text,
                          int.parse(controller.stoke.text),
                          int.parse(controller.price.text),
                          controller.desc.text,
                        );
                      }
                    },
                    child: const Text('Edit'),
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
