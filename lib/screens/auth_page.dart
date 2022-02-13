import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:hospital_control/controllers/auth_controller.dart';

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
                onEmpty: ElevatedButton(
                  child: const Padding(
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
                onError: (err) => ElevatedButton(
                  child: Padding(
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
            ],
          ),
        ),
      ),
    );
  }
}

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final bool autofocus;
  final Widget? icon;

  const AuthTextField({
    Key? key,
    required this.controller,
    required this.hint,
    this.obscure = false,
    this.autofocus = false,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autofocus: autofocus,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        icon: icon,
      ),
    );
  }
}
