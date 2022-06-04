import 'package:flutter/material.dart';
import 'package:poktan_app/app/modules/produk/controllers/produk_controller.dart';
import 'package:poktan_app/app/routes/app_pages.dart';
import 'package:poktan_app/app/utils/base_url.dart';
import 'package:poktan_app/app/utils/constant.dart';

import 'package:get/get.dart';

class ItemView extends GetView<ProdukController> {
  const ItemView(this.data);
  final data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.getPhotoProductById(data.id);
        Get.toNamed(Routes.DETAIL_PRODUK, arguments: data.slug!);
      },
      // onTap: () {},
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Expanded(
              child: Hero(
                tag: data.slug,
                child: Center(
                  child: Image.network(
                      baseUrlFile + "storage/produk/" + data.image!),
                ),
              ),
            ),
            ListTile(
              title: Text(
                data.name,
                style: const TextStyle(
                    color: Color(0xff919A92),
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
              subtitle: Text(
                'Rp ${formatCurrency.format(data.price!)}',
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Row(children: [
                    InkWell(
                      onTap: () {
                        controller.getPhotoProductById(data.id!);
                        Get.toNamed(
                          Routes.EDIT_PRODUK,
                          arguments: data.id,
                        );
                      },
                      child: const Icon(
                        Icons.edit,
                        size: 23,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        controller.dialogQuestion(context, data.id!);
                      },
                      child: const Icon(
                        Icons.delete,
                        size: 23,
                        color: Colors.grey,
                      ),
                    )
                  ]),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
