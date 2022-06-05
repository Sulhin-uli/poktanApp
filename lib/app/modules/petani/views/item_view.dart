import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poktan_app/app/modules/petani/controllers/petani_controller.dart';
import 'package:poktan_app/app/routes/app_pages.dart';

class ItemView extends GetView<PetaniController> {
  const ItemView(this.data);
  final data;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.DETAIL_PETANI, arguments: data.id!),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            ListTile(
              leading: const CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://www.startupdonut.co.uk/sites/default/files/styles/landing_pages_lists/public/Guy_watson_249x167.png?itok=e_ct04Rx'),
              ),
              title: Text(data.userId!.name),
              trailing: Wrap(
                spacing: 1, // space between two icons
                children: [
                  InkWell(
                    onTap: () =>
                        Get.toNamed(Routes.EDIT_PETANI, arguments: data.id),
                    child: const Icon(
                      Icons.edit,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 5),
                  InkWell(
                    onTap: () =>
                        controller.dialogQuestion(context, data.userId!.id!),
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
      ),
    );
  }
}
