import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:hospital_control/controllers/register_controller.dart';
import 'package:hospital_control/screens/common/auth_textfield.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usernameEditingController = TextEditingController();
    final passwordEditingController = TextEditingController();
    final confirmationEditingController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Регистрация'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AuthTextField(
                  controller: usernameEditingController,
                  hint: 'Логин',
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
                AuthTextField(
                  controller: confirmationEditingController,
                  hint: 'Подтвердите пароль',
                  obscure: true,
                  icon: const Icon(Icons.replay),
                ),
                const SizedBox(height: 8),
                controller.obx(
                  (status) {
                    SchedulerBinding.instance
                        ?.addPostFrameCallback((_) => Get.offNamed('/auth'));
                    return const Text('Вы зарегистрированы!');
                  },
                  onEmpty: ElevatedButton.icon(
                    onPressed: () {
                      if (passwordEditingController.text ==
                          confirmationEditingController.text) {
                        controller.register(
                          username: usernameEditingController.text,
                          password: passwordEditingController.text,
                        );
                      }
                    },
                    icon: const Icon(Icons.how_to_reg),
                    label: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Зарегистрироваться'),
                    ),
                  ),
                  onLoading: const CircularProgressIndicator(),
                  onError: (err) => ElevatedButton.icon(
                    onPressed: () {
                      if (passwordEditingController.text ==
                          confirmationEditingController.text) {
                        controller.register(
                          username: usernameEditingController.text,
                          password: passwordEditingController.text,
                        );
                      }
                    },
                    icon: const Icon(Icons.how_to_reg),
                    label: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Зарегистрироваться ($err)'),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: () {
                    Get.offNamed('/auth');
                  },
                  icon: const Icon(Icons.login),
                  label: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Войти'),
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
