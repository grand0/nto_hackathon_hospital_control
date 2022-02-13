import 'dart:convert';

import 'package:get/get.dart';
import 'package:hospital_control/models/data_model.dart';
import 'package:hospital_control/models/post_temp_model.dart';

class ApiProvider extends GetConnect {
  String url = 'http://26.204.52.161/api/';

  Future<DataModel> getData() async {
    final resp = await get('${url}data');
    if (resp.status.hasError) {
      return Future.error(resp.statusText ?? '');
    } else {
      return DataModel.fromJson(jsonDecode(resp.bodyString ?? ''));
    }
  }

  Future<void> postTemp(double minTemp, double maxTemp) async {
    print(PostTempModel(minTemperature: minTemp, maxTemperature: maxTemp)
        .toJson().toString());
    final resp = await post(
        '${url}settings',
        PostTempModel(minTemperature: minTemp, maxTemperature: maxTemp)
            .toJson(), contentType: 'application/json');
    if (resp.status.hasError) {
      return Future.error(resp.statusText ?? '');
    }
  }
}
