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
            trailing: Wrap(
              spacing: 1, // space between two icons
              children: [
                InkWell(
                  onTap: () => Get.toNamed(Routes.EDIT_ACTIVITY_CATEGORY,
                      arguments: data.id),
                  child: const Icon(
                    Icons.edit,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 5),
                InkWell(
                  onTap: () => controller.dialogQuestion(context, data.id),
                  child: const Icon(
                    Icons.delete,
                    size: 20,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
