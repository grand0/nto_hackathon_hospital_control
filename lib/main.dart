import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_control/bindings/register_binding.dart';
import 'package:hospital_control/bindings/auth_binding.dart';
import 'package:hospital_control/bindings/home_binding.dart';
import 'package:hospital_control/screens/auth_page.dart';
import 'package:hospital_control/screens/home_page.dart';
import 'package:hospital_control/screens/register_page.dart';

void main() => runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/auth',
      getPages: [
        GetPage(
          name: '/',
          page: () => HomePage(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: '/auth',
          page: () => AuthPage(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: '/register',
          page: () => RegisterPage(),
          binding: RegisterBinding(),
        ),
      ],
    ));
