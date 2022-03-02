import 'package:get/get.dart';
import 'package:hospital_control/models/auth_models.dart';
import 'package:hospital_control/providers/api_provider.dart';

class RegisterController extends GetxController
    with StateMixin<RegisterStatus> {

  final ApiProvider _apiProvider = ApiProvider();

  @override
  void onInit() {
    change(null, status: RxStatus.empty());
    super.onInit();
  }

  void register({required String username, required String password}) {
    change(null, status: RxStatus.loading());
    _apiProvider.register(username: username, password: password).then(
      (model) {
        if (model.registered) {
          change(model, status: RxStatus.success());
        } else {
          change(null, status: RxStatus.empty());
        }
      },
      onError: (err) {
        change(null, status: RxStatus.error(err.toString()));
      },
    );
  }
}
