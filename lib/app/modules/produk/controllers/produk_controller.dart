import 'package:flutter/material.dart';
import 'package:poktan_app/app/data/models/photo_product_model.dart';
import 'package:poktan_app/app/data/models/product_category_model.dart';
import 'package:poktan_app/app/data/models/product_model.dart';
import 'package:poktan_app/app/data/models/user_model.dart';
import 'package:poktan_app/app/data/providers/photo_product_provider.dart';
import 'package:poktan_app/app/data/providers/product_provider.dart';
import 'package:poktan_app/app/routes/app_pages.dart';
import 'package:poktan_app/app/utils/base_url.dart';
import 'package:poktan_app/app/utils/constant.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class ProdukController extends GetxController {
  var visibleEditPhoto = true.obs;
  var carouselIndex = 0.obs;
  final box = GetStorage();
  late TextEditingController name;
  late TextEditingController categoryProductId;
  late TextEditingController code;
  late TextEditingController stoke;
  late TextEditingController price;
  late TextEditingController desc;
  var product = List<Product>.empty().obs;
  var photoProduct = List<PhotoProduct>.empty().obs;
  var photoProductByProductId = List<PhotoProduct>.empty().obs;
  var selectedImagePath = List<XFile>.empty().obs;

  @override
  void onInit() {
    getDataPhoto();
    getData();
    super.onInit();
    name = TextEditingController();
    categoryProductId = TextEditingController();
    code = TextEditingController();
    stoke = TextEditingController();
    price = TextEditingController();
    desc = TextEditingController();
  }

  void getPhotoProductById(int productId) {
    for (var item in photoProduct) {
      if (item.productId!.id == productId) {
        final data = PhotoProduct(
          id: item.id,
          productId: Product(
            id: item.productId!.id,
            name: item.productId!.name,
            slug: item.productId!.slug,
            categoryProductId: ProductCategory(
              id: item.productId!.categoryProductId!.id,
              name: item.productId!.categoryProductId!.name,
              slug: item.productId!.categoryProductId!.slug,
              createdAt: item.productId!.categoryProductId!.createdAt,
              updatedAt: item.productId!.categoryProductId!.updatedAt,
            ),
            code: item.productId!.code,
            stoke: item.productId!.stoke,
            price: item.productId!.price,
            desc: item.productId!.desc,
            userId: User(
              id: item.productId!.userId!.id,
              name: item.productId!.userId!.name,
            ),
            isActive: item.productId!.isActive,
          ),
          name: item.name,
          createdAt: item.createdAt,
          updatedAt: item.updatedAt,
        );
        photoProductByProductId.insert(0, data);
      } else {
        print("not found");
      }
    }
  }

  getMultipleImage() async {
    final List<XFile>? pickedFile = await ImagePicker().pickMultiImage();
    if (pickedFile!.isNotEmpty) {
      selectedImagePath.addAll(pickedFile);
    } else {
      Get.snackbar(
        "Warning",
        "No image Selected",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.grey,
        colorText: Colors.white,
      );
    }
  }

  // add data
  void postData(
    String name,
    int categoryProductId,
    String code,
    int stoke,
    int price,
    String desc,
  ) async {
    final data = box.read("userData") as Map<String, dynamic>;
    if (name != '') {
      ProductProvider()
          .postData(name, categoryProductId, data["id"], code, stoke, price,
              desc, data["token"])
          .then((response) {
        // print(response);
        final data = Product(
          id: response["data"]["id"],
          name: response["data"]["name"],
          slug: response["data"]["slug"],
          categoryProductId: ProductCategory(
            id: response["data"]["category_product_id"]["id"],
            name: response["data"]["category_product_id"]["name"],
            slug: response["data"]["category_product_id"]["slug"],
            createdAt: response["data"]["category_product_id"]["created_at"],
            updatedAt: response["data"]["category_product_id"]["updated_at"],
          ),
          code: response["data"]["code"],
          stoke: response["data"]["stoke"],
          price: response["data"]["price"],
          desc: response["data"]["desc"],
          userId: User(
            id: response["data"]["user_id"]["id"],
            name: response["data"]["user_id"]["name"],
          ),
          isActive: response["data"]["isActive"],
        );
        product.insert(0, data);
        for (var item in selectedImagePath) {
          postPhoto(item.path, response["data"]["id"]);

          Future.delayed(const Duration(seconds: 1), () {});
        }

        // for (var itemPhoto in photoProduct) {
        //   if (itemPhoto.productId!.id == response["data"]["id"]) {
        //     print("ada");
        //     // itemProduct.image = itemPhoto.name;
        //     // product.refresh();
        //   } else {
        //     print("tidak ada");
        //   }
        // }

        // Get.back();
        Get.offAllNamed(Routes.HOME);
        dialog("Berhasil !", "data berhasil ditambahkan!");
      });
    } else {
      dialog("Terjadi Kesalahan", "Semua Input Harus Diisi");
    }
  }

  void postPhoto(String file, int productId) {
    final data = box.read("userData") as Map<String, dynamic>;
    if (name != '' && productId != '') {
      try {
        Map<String, String> body = {
          "product_id": productId.toString(),
        };
        PhotoProductProvider()
            .postData(body, file, data["token"])
            .then((response) {
          // print(response);
          final data = PhotoProduct(
            id: response["data"]["id"],
            productId: Product(
              id: response["data"]["product_id"]["id"],
              name: response["data"]["product_id"]["name"],
              slug: response["data"]["product_id"]["slug"],
              categoryProductId: ProductCategory(
                id: response["data"]["product_id"]["category_product_id"]["id"],
                name: response["data"]["product_id"]["category_product_id"]
                    ["name"],
                slug: response["data"]["product_id"]["category_product_id"]
                    ["slug"],
                createdAt: response["data"]["product_id"]["category_product_id"]
                    ["created_at"],
                updatedAt: response["data"]["product_id"]["category_product_id"]
                    ["updated_at"],
              ),
              code: response["data"]["product_id"]["code"],
              stoke: response["data"]["product_id"]["stoke"],
              price: response["data"]["product_id"]["price"],
              desc: response["data"]["product_id"]["desc"],
              userId: User(
                id: response["data"]["product_id"]["category_product_id"]["id"],
                name: response["data"]["product_id"]["category_product_id"]
                    ["name"],
              ),
              isActive: response["data"]["product_id"]["isActive"],
            ),
            name: response["data"]["name"],
            createdAt: response["data"]["created_at"],
            updatedAt: response["data"]["updated_at"],
          );
          photoProduct.insert(0, data);
        });
      } catch (e) {
        dialog("Terjadi Kesalahan", "data gagal ditambahkan");
        print("error is $e");
      }
    } else {
      dialog("Terjadi Kesalahan", "Semua Input Harus Diisi");
    }
  }

  void getData() async {
    final data = box.read("userData") as Map<String, dynamic>;

    ProductProvider().getData(data["token"]).then((response) {
      try {
        response["data"].map((e) {
          final data = Product(
            id: e["id"],
            name: e["name"],
            slug: e["slug"],
            categoryProductId: ProductCategory(
              id: e["category_product_id"]["id"],
              name: e["category_product_id"]["name"],
              slug: e["category_product_id"]["slug"],
              createdAt: e["category_product_id"]["created_at"],
              updatedAt: e["category_product_id"]["updated_at"],
            ),
            code: e["code"],
            stoke: e["stoke"],
            price: e["price"],
            desc: e["desc"],
            userId: User(
              id: e["category_product_id"]["id"],
              name: e["category_product_id"]["name"],
            ),
            isActive: e["isActive"],
          );
          product.add(data);
          final item = findByid(e["id"]);
          for (var itemPhoto in photoProduct) {
            // item.image = itemPhoto.name;
            if (itemPhoto.productId!.id == item.id) {
              item.image = itemPhoto.name;
              product.refresh();
            }
          }
        }).toList();
      } catch (e) {
        print(e.toString());
      }
    });
  }

  void getDataPhoto() async {
    final data = box.read("userData") as Map<String, dynamic>;
    PhotoProductProvider().getData(data["token"]).then((response) {
      try {
        response["data"].map((e) {
          final data = PhotoProduct(
            id: e["id"],
            productId: Product(
              id: e["product_id"]["id"],
              name: e["product_id"]["name"],
              slug: e["product_id"]["slug"],
              categoryProductId: ProductCategory(
                id: e["product_id"]["category_product_id"]["id"],
                name: e["product_id"]["category_product_id"]["name"],
                slug: e["product_id"]["category_product_id"]["slug"],
                createdAt: e["product_id"]["category_product_id"]["created_at"],
                updatedAt: e["product_id"]["category_product_id"]["updated_at"],
              ),
              code: e["product_id"]["code"],
              stoke: e["product_id"]["stoke"],
              price: e["product_id"]["price"],
              desc: e["product_id"]["desc"],
              userId: User(
                id: e["product_id"]["user_id"]["id"],
                name: e["product_id"]["user_id"]["name"],
              ),
              isActive: e["product_id"]["isActive"],
            ),
            name: e["name"],
            createdAt: e["created_at"],
            updatedAt: e["updated_at"],
          );
          photoProduct.add(data);
        }).toList();
      } catch (e) {
        print(e.toString());
      }
    });
  }

  PhotoProduct findPhotoByidProduct(int id) {
    return photoProduct.firstWhere((element) => element.productId!.id == id);
  }

  // cari berdasarka id
  Product findByid(int id) {
    return product.firstWhere((element) => element.id == id);
  }

  // cari berdasarka slug
  Product findBySlug(String slug) {
    return product.firstWhere((element) => element.slug == slug);
  }

  void updateData(
    int id,
    String name,
    int categoryProductId,
    String code,
    int stoke,
    int price,
    String desc,
  ) {
    final data = box.read("userData") as Map<String, dynamic>;
    final item = findByid(id);
    ProductProvider()
        .updateData(id, name, categoryProductId, data["id"], code, stoke, price,
            desc, data["token"])
        .then((e) {
      item.name = name;
      item.categoryProductId!.id = categoryProductId;
      item.userId!.id = data["id"];
      item.code = code;
      item.stoke = stoke;
      item.price = price;
      item.desc = desc;
      product.refresh();
      Get.back();
      dialog("Berhasil !", "data berhasil diubah!");
    });
  }

  void updateDataWithPhoto(
    int id,
    String name,
    int categoryProductId,
    String code,
    int stoke,
    int price,
    String desc,
  ) {
    final data = box.read("userData") as Map<String, dynamic>;
    final item = findByid(id);
    ProductProvider()
        .updateData(id, name, categoryProductId, data["id"], code, stoke, price,
            desc, data["token"])
        .then((e) {
      item.name = name;
      item.categoryProductId!.id = categoryProductId;
      item.userId!.id = data["id"];
      item.code = code;
      item.stoke = stoke;
      item.price = price;
      item.desc = desc;
      product.refresh();

      for (var itemselectedImagePath in selectedImagePath) {
        postPhoto(itemselectedImagePath.path, id);
        Future.delayed(const Duration(seconds: 1), () {});
      }
      deleteDataWhereProductId(id);
      Get.offAllNamed(Routes.HOME);
      dialog("Berhasil !", "data berhasil diubah!");
    });
  }

  void deleteDataWhereProductId(int id) {
    final data = box.read("userData") as Map<String, dynamic>;
    PhotoProductProvider()
        .deleteDataWhereProductId(id, data["token"])
        .then((_) => product.removeWhere((element) => element.id == id));
    print("data berhasil dihapus");
  }

  void deleteData(int id) {
    final data = box.read("userData") as Map<String, dynamic>;
    ProductProvider()
        .deleteData(id, data["token"])
        .then((_) => product.removeWhere((element) => element.id == id));
    dialog("Berhasil !", "data berhasil dihapus!");
  }

  void dialogQuestion(BuildContext context, int id) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Peringatan"),
        content: const Text("Yakin menghapus data?"),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Batal'),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'Ya');
              deleteData(id);
              deleteDataWhereProductId(id);
            },
            child: const Text('Ya'),
          ),
        ],
      ),
    );
  }
}
