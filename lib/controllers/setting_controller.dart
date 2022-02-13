import 'package:get/get.dart';

class SettingController extends GetxController {
  Rx<double> value;
  final double minValue;
  final double maxValue;

  SettingController({
    required double value,
    this.minValue = 0.0,
    this.maxValue = 100.0,
  }) : this.value = value.obs;

  void setValue(double newValue) {
    value = newValue.obs;
    update();
  }
}
