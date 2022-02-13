import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_control/binidngs/home_binding.dart';
import 'package:hospital_control/screens/home_page.dart';

void main() => runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => HomePage(),
          binding: HomeBinding(),
        ),
      ],
    ));
