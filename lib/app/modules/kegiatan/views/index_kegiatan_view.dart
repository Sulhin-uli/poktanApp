import 'package:flutter/material.dart';
import 'package:poktan_app/app/modules/kegiatan/views/item_view.dart';
import 'package:poktan_app/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../controllers/kegiatan_controller.dart';

class IndexKegiatanView extends GetView<KegiatanController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   // leading: BackButton(color: Colors.black),
      //   title: Text(
      //     'Kegiatan',
      //     style: TextStyle(color: Colors.black, fontSize: 16),
      //   ),
      //   elevation: 0.5,
      // ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Column(
            children: [
              ListView.builder(
                itemCount: 11,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  // final product = productList[index];
                  return ItemView();
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff16A085),
        foregroundColor: Colors.white,
        // mini: true,
        onPressed: () => Get.toNamed(Routes.ADD_KEGIATAN),
        child: Icon(Icons.add),
      ),
    );
  }
}
