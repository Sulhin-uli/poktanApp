import 'package:flutter/material.dart';
import 'package:poktan_app/app/modules/activity/controllers/activity_controller.dart';
import 'package:poktan_app/app/routes/app_pages.dart';
import 'package:format_indonesia/format_indonesia.dart';

import 'package:get/get.dart';

class ItemActivityView extends GetView<ActivityController> {
  const ItemActivityView(this.data);
  final data;

  @override
  Widget build(BuildContext context) {
    DateTime datetime = DateTime.parse(data.date!);
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.DETAIL_ACTIVITY, arguments: data.id),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              child: ListTile(
                title: Container(
                    margin: const EdgeInsets.only(
                      bottom: 6,
                    ),
                    child: Text(data.title)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.userId.name,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      Waktu(datetime).yMMMMEEEEd(),
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ],
                ),
                trailing: Wrap(
                  spacing: 1, // space between two icons
                  children: [
                    InkWell(
                      onTap: () =>
                          Get.toNamed(Routes.EDIT_ACTIVITY, arguments: data.id),
                      child: const Icon(
                        Icons.edit,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 5),
                    InkWell(
                      onTap: () => controller.dialogQuestion(
                          "Hapus", "Yakin menghapus data?", context, data.id!),
                      child: const Icon(
                        Icons.delete,
                        size: 20,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
