import 'package:poktan_app/app/utils/base_url.dart';
import 'package:get/get.dart';

class ProductProvider extends GetConnect {
  String url = baseUrl + "product";

  Future<dynamic> postData(
    String name,
    int categoryProductId,
    int userId,
    String code,
    int stoke,
    int price,
    String desc,
    String token,
  ) async {
    final response = await post(url, {
      "name": name,
      "category_product_id": categoryProductId,
      "code": code,
      "stoke": stoke,
      "price": price,
      "user_id": userId,
      "desc": desc,
    }, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    return response.body;
  }

  Future<dynamic> getData(
    String token,
  ) async {
    final response = await get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    return response.body;
  }

  Future<void> deleteData(
    int? id,
    String token,
  ) async =>
      await delete(url + '/$id', headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

  Future<void> updateData(
    int id,
    String name,
    int categoryProductId,
    int userId,
    String code,
    int stoke,
    int price,
    String desc,
    String token,
  ) async {
    final response = await put(url + '/$id', {
      "name": name,
      "category_product_id": categoryProductId,
      "code": code,
      "stoke": stoke,
      "price": price,
      "user_id": userId,
      "desc": desc,
    }, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    return response.body;
  }
}
