import 'package:flutter/material.dart';
import 'package:poktan_app/app/modules/poktan/views/item_view.dart';
import 'package:poktan_app/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../controllers/poktan_controller.dart';

class IndexPoktanView extends GetView<PoktanController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff16A085),
        elevation: 0,
      ),
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
        onPressed: () => Get.toNamed(Routes.ADD_POKTAN),
        child: Icon(Icons.add),
      ),
    );
  }
}
