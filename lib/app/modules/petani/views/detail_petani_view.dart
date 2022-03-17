import 'package:flutter/material.dart';
import 'package:poktan_app/app/modules/petani/controllers/petani_controller.dart';
import 'package:poktan_app/app/routes/app_pages.dart';

import 'package:get/get.dart';

class DetailPetaniView extends GetView<PetaniController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Detail Petani',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        leading: BackButton(color: Colors.black),
        actions: [
          Container(
            alignment: Alignment.topRight,
            child: PopupMenuButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
              itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                PopupMenuItem(
                  child: ListTile(
                    onTap: () => Get.toNamed(Routes.EDIT_PETANI),
                    leading: Icon(Icons.edit),
                    title: Text('Ubah'),
                  ),
                ),
                PopupMenuItem(
                  child: ListTile(
                    onTap: () {
                      controller.dialogQuestion(
                          "Hapus", "Yakin menghapus data?", context);
                    },
                    leading: Icon(Icons.delete),
                    title: Text('Delete'),
                  ),
                ),
              ],
            ),
          ),
        ],
        elevation: 0.5,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(),
      ),
    );
  }
}
