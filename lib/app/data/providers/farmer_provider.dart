import 'package:poktan_app/app/utils/base_url.dart';
import 'package:get/get.dart';


class FarmerProvider extends GetConnect {
  String url = baseUrl + "farmer";

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
}
