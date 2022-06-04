import 'dart:io';

import 'package:flutter/material.dart';
import 'package:poktan_app/app/modules/home/controllers/home_controller.dart';
import 'package:poktan_app/app/modules/login/controllers/login_controller.dart';
import 'package:poktan_app/app/routes/app_pages.dart';
import 'package:poktan_app/app/utils/base_url.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/saya_controller.dart';

class IndexSayaView extends GetView<SayaController> {
  final loginC = Get.find<LoginController>();
  final homeC = Get.find<HomeController>();
  final box = GetStorage();
  SayaController sayaController = Get.put(SayaController());

  @override
  Widget build(BuildContext context) {
    final user = box.read("userData") as Map<String, dynamic>;
    final data = loginC.findGapoktan(user["id"]);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Center(
                    child: Stack(
                      children: <Widget>[
                        Obx(
                          () => Container(
                            margin: EdgeInsets.all(15),
                            width: 175,
                            height: 175,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(200),
                              child: sayaController
                                      .selectedImagePath.value.isImageFileName
                                  ? Image.file(
                                      File(sayaController
                                          .selectedImagePath.value),
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    )
                                  : data.image == null
                                      ? Image.asset(
                                          'assets/images/noimage.png',
                                          height: 150,
                                          width: 150,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.network(
                                          baseUrlFile +
                                              "storage/profile/" +
                                              data.image!,
                                          height: 150,
                                          width: 150,
                                          fit: BoxFit.cover,
                                        ),
                            ),
                          ),
                        ),
                        Positioned(
                            bottom: 1,
                            right: 1,
                            child: InkWell(
                              onTap: () => sayaController.getImage(),
                              child: Container(
                                height: 40,
                                width: 40,
                                child: Icon(
                                  Icons.add_a_photo,
                                  color: Colors.white,
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                              ),
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  Text(
                    data.chairman!,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                child: Column(
                  children: [
                    Divider(
                      color: Color(0xff919A92),
                    ),
                    ListTile(
                      leading: Icon(Icons.home),
                      title: Text('Kembali Ke Home'),
                      onTap: () {
                        homeC.changeTabIndex(0);
                      },
                    ),
                    Divider(
                      color: Color(0xff919A92),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 16,
                ),
                child: Text(
                  "Aktivitas Saya",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                onTap: () => Get.toNamed(Routes.INDEX_EDUCATION),
                leading: Icon(Icons.circle),
                title: Text('Edukasi'),
              ),
              ListTile(
                onTap: () => Get.toNamed(Routes.INDEX_PRODUK),
                leading: Icon(Icons.circle),
                title: Text('Produk'),
              ),
              ListTile(
                onTap: () => Get.toNamed(Routes.INDEX_ACTIVITY),
                leading: Icon(Icons.circle),
                title: Text('Kegiatan'),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 16,
                ),
                child: Text(
                  "Pengaturan Akun",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                onTap: () => Get.toNamed(Routes.EDIT_PROFILE),
                leading: Icon(Icons.person),
                title: Text('Ubah Akun'),
              ),
              ListTile(
                onTap: () => Get.toNamed(Routes.EDIT_PASSWORD),
                leading: Icon(Icons.vpn_key),
                title: Text('Ubah Password'),
              ),
              GestureDetector(
                onTap: () {
                  box.erase();
                  Get.offAndToNamed(Routes.LOGIN);
                },
                child: ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
