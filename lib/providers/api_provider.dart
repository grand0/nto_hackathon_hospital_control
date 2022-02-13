import 'dart:convert';

import 'package:get/get.dart';
import 'package:hospital_control/models/auth_models.dart';
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
    final resp = await post(
        '${url}settings',
        PostTempModel(minTemperature: minTemp, maxTemperature: maxTemp)
            .toJson(),
        contentType: 'application/json');
    if (resp.status.hasError) {
      return Future.error(resp.statusText ?? '');
    }
  }

  Future<AuthStatus> auth(
      {required String username, required String password}) async {
    final resp = await post(
        '${url}auth', UserModel(username, password).toJson(),
        contentType: 'application/json');
    if (resp.status.hasError) {
      return Future.error(resp.statusText ?? '');
    } else {
      return AuthStatus.fromJson(jsonDecode(resp.bodyString ?? ''));
    }
  }
}
