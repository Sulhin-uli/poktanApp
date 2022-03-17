import 'package:flutter/material.dart';
import 'package:poktan_app/app/modules/tandur/views/item_view.dart';

import 'package:get/get.dart';

import '../controllers/tandur_controller.dart';

class IndexTandurView extends GetView<TandurController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(color: Colors.black),
        title: Text(
          'Jadwal Tandur',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        elevation: 0.5,
      ),
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
    );
  }
}
