import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:poktan_app/app/modules/petani/views/item_view.dart';
import 'package:poktan_app/app/routes/app_pages.dart';

import '../controllers/petani_controller.dart';

class IndexPetaniView extends GetView<PetaniController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Poktan',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        elevation: 0.5,
      ),
      backgroundColor: Colors.white,
      body: Obx(
        () => controller.farmer.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Column(
                    children: [
                      ListView.builder(
                        itemCount: controller.farmer.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final data = controller.farmer[index];
                          return ItemView(data);
                        },
                      )
                    ],
                  ),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff16A085),
        foregroundColor: Colors.white,
        // mini: true,
        onPressed: () => Get.toNamed(Routes.ADD_PETANI),
        child: const Icon(Icons.add),
      ),
    );
  }
}
