import 'dart:async';

import 'package:get/get.dart';
import 'package:hospital_control/controllers/data_controller.dart';
import 'package:hospital_control/controllers/setting_controller.dart';
import 'package:hospital_control/controllers/split_view_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SplitViewController>(SplitViewController());
    Get.put<SettingController>(
        SettingController(value: 20.0, minValue: 15.0, maxValue: 30.0),
        tag: "min_temperature");
    Get.put<SettingController>(
        SettingController(value: 20.0, minValue: 15.0, maxValue: 30.0),
        tag: "max_temperature");
    final dataController = Get.put<DataController>(DataController());
    Timer.periodic(const Duration(seconds: 5), (timer) {
      dataController.loadData();
    });
  }
}
