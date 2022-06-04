import 'package:flutter/material.dart';
import 'package:poktan_app/app/modules/activity_category/controllers/activity_category_controller.dart';
import 'package:poktan_app/app/routes/app_pages.dart';

import 'package:get/get.dart';

class ItemViewCategoryActivity extends GetView<ActivityCategoryController> {
  const ItemViewCategoryActivity(this.data);
  final data;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            title: Text(data.name),
          ),
        ],
      ),
    );
  }
}
