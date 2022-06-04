import 'package:poktan_app/app/utils/base_url.dart';
import 'package:get/get.dart';

class PlantProvider extends GetConnect {
  String url = baseUrl + "plant";

  Future<dynamic> postData(
    int farmerId,
    int poktanId,
    String plantTanaman,
    String surfaceArea,
    String platingDate,
    dynamic harvestDate,
    String token,
  ) async {
    final response = await post(url, {
      "farmer_id": farmerId,
      "poktan_id": poktanId,
      "plant_tanaman": plantTanaman,
      "surface_area": surfaceArea,
      "plating_date": platingDate,
      "harvest_date": harvestDate,
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

  Future<void> updateData(
    int id,
    String plantTanaman,
    String surfaceArea,
    String platingDate,
    String harvestDate,
    String token,
  ) async {
    final response = await put(url + '/$id', {
      "plant_tanaman": plantTanaman,
      "surface_area": surfaceArea,
      "plating_date": platingDate,
      "harvest_date": harvestDate,
    }, headers: {
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
      await delete(
        url + '/$id',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

  Future<void> addHarvestDate(
    int id,
    String harvestDate,
    String token,
  ) async {
    final response = await put('$url/harvest-date' '/$id', {
      "harvest_date": harvestDate,
    }, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    return response.body;
  }
}
