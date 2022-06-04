import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FormEducationController extends GetxController {
  // form
  late TextEditingController category_education_id;
  late TextEditingController title;
  late TextEditingController file;
  late TextEditingController desc;

  // upload image
  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;

  // upload image api
  // crop Image
  var cropImagePath = ''.obs;
  var cropImageSize = ''.obs;

  // Compress code
  var compressedFile;
  var compressImagePath = ''.obs;
  var compressImageSize = ''.obs;

  @override
  void onInit() {
    super.onInit();

    // form
    category_education_id = TextEditingController();
    title = TextEditingController();
    file = TextEditingController();
    desc = TextEditingController();
  }

  // dialog upload File
  void dialogUploadFile() {
    Get.defaultDialog(
      title: "Pilih file",
      content: Container(
        child: Column(
          children: [
            ListTile(
              onTap: () => getImage(ImageSource.gallery),
              leading: const Icon(Icons.image),
              title: const Text("Gambar"),
            ),
            const ListTile(
              leading: Icon(Icons.video_library),
              title: Text("Video"),
            ),
          ],
        ),
      ),
    );
  }

  void getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().getImage(source: imageSource);

    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      selectedImageSize.value =
          ((File(selectedImagePath.value)).lengthSync() / 1024 / 1024)
                  .toStringAsFixed(2) +
              " Mb";
      final dir = Directory.systemTemp;
      final targetPath = dir.absolute.path + "/temp.jpg";
      compressedFile = await FlutterImageCompress.compressAndGetFile(
          cropImagePath.value, targetPath,
          quality: 90);
      compressImagePath.value = compressedFile!.path;
      compressImageSize.value =
          ((File(compressImagePath.value)).lengthSync() / 1024 / 1024)
                  .toStringAsFixed(2) +
              " Mb";
    } else {
      Get.snackbar(
        "Error",
        "No image Selected",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // void uploadImage(File file) {
  //   Get.dialog(
  //     Center(
  //       child: CircularProgressIndicator(),
  //     ),
  //     barrierDismissible: false,
  //   );
  //   EducationCategoryProvider().post(file).then((resp) {
  //     Get.back();
  //     if (resp == "success") {
  //       Get.snackbar('Success', 'File Uploaded',
  //           snackPosition: SnackPosition.BOTTOM,
  //           backgroundColor: Colors.green,
  //           colorText: Colors.white);
  //     } else if (resp == "fail") {
  //       Get.snackbar('Error', 'File upload failed',
  //           snackPosition: SnackPosition.BOTTOM,
  //           backgroundColor: Colors.red,
  //           colorText: Colors.white);
  //     }
  //   }, onError: (err) {
  //     Get.back();
  //     Get.snackbar('Error', 'File upload failed',
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white);
  //   });
  // }
}
