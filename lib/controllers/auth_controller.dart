import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hospital_control/models/auth_models.dart';
import 'package:hospital_control/providers/api_provider.dart';

class AuthController extends GetxController with StateMixin<AuthStatus> {
  final ApiProvider _apiProvider = ApiProvider();
  var authStatus = Status.noUser.obs;

  @override
  void onInit() {
    change(null, status: RxStatus.empty());
    super.onInit();
  }

  void auth({required String username, required String password}) {
    change(null, status: RxStatus.loading());
    _apiProvider.auth(username: username, password: password).then(
      (model) {
        print(model.status);
        if (model.status == Status.noUser) {
          change(null, status: RxStatus.empty());
        } else {
          change(model, status: RxStatus.success());
        }
        authStatus = model.status.obs;
      },
      onError: (err) {
        change(null, status: RxStatus.error(err.toString()));
        if (kDebugMode) {
          print(err);
        }
      },
    );
  }
}
