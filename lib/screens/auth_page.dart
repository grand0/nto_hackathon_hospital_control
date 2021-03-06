import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:hospital_control/controllers/auth_controller.dart';
import 'package:hospital_control/screens/common/auth_textfield.dart';

class AuthPage extends GetView<AuthController> {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usernameEditingController = TextEditingController();
    final passwordEditingController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Вход'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                AuthTextField(
                  controller: usernameEditingController,
                  hint: 'Пользователь',
                  autofocus: true,
                  icon: const Icon(Icons.person),
                ),
                const SizedBox(height: 8),
                AuthTextField(
                  controller: passwordEditingController,
                  hint: 'Пароль',
                  obscure: true,
                  icon: const Icon(Icons.lock),
                ),
                const SizedBox(height: 8),
                controller.obx(
                  (status) {
                    SchedulerBinding.instance?.addPostFrameCallback(
                        (_) => Get.offNamed('/', arguments: status));
                    return const Text('Вход выполнен!');
                  },
                  onEmpty: ElevatedButton.icon(
                    icon: const Icon(Icons.login),
                    label: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Войти'),
                    ),
                    onPressed: () {
                      controller.auth(
                        username: usernameEditingController.text,
                        password: passwordEditingController.text,
                      );
                    },
                  ),
                  onLoading: const CircularProgressIndicator(),
                  onError: (err) => ElevatedButton.icon(
                    icon: const Icon(Icons.login),
                    label: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Войти ($err)'),
                    ),
                    onPressed: () {
                      controller.auth(
                        username: usernameEditingController.text,
                        password: passwordEditingController.text,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: () {
                    Get.offNamed('/register');
                  },
                  icon: const Icon(Icons.how_to_reg),
                  label: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Регистрация'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
