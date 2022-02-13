import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hospital_control/models/data_model.dart';
import 'package:hospital_control/providers/api_provider.dart';

class DataController extends GetxController with StateMixin<DataModel> {
  final ApiProvider _apiProvider = ApiProvider();
  double lastMinTemp = 20.0;
  double lastMaxTemp = 20.0;

  void loadData() {
    _apiProvider.getData().then(
      (model) {
        change(model, status: RxStatus.success());
      },
      onError: (err) {
        change(null, status: RxStatus.error(err.toString()));
        if (kDebugMode) {
          print(err);
        }
      },
    );
  }

  void postTemp({double? minTemp, double? maxTemp}) {
    if (!checkForTemps(minTemp: minTemp, maxTemp: maxTemp)) {
      return;
    }
    _apiProvider.postTemp(minTemp ?? lastMinTemp, maxTemp ?? lastMaxTemp);
    lastMinTemp = minTemp ?? lastMinTemp;
    lastMaxTemp = maxTemp ?? lastMaxTemp;
  }

  bool checkForTemps({double? minTemp, double? maxTemp}) {
    return (minTemp ?? lastMinTemp) <= (maxTemp ?? lastMaxTemp);
  }
}
