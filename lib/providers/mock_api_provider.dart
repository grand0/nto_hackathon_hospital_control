import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:hospital_control/models/auth_models.dart';
import 'package:hospital_control/models/data_model.dart';
import 'package:hospital_control/providers/api_provider.dart';

class MockApiProvider extends ApiProvider {
  @override
  Future<DataModel> getData() async {
    return await Future.delayed(
      const Duration(seconds: 2),
      () => DataModel(
        temperature: 18.0 + Random().nextInt(10),
        humidity: 40.0 + Random().nextInt(20),
        light: 200.0 + Random().nextInt(50),
        energy: 1.0 + Random().nextDouble() * 2,
        motion: Random().nextBool(),
        open: Random().nextBool(),
        heater: Random().nextBool(),
        cooler: Random().nextBool(),
        unknownCard: Random().nextBool(),
        thief: Random().nextBool(),
      ),
    );
  }

  @override
  Future<void> postTemp(double minTemp, double maxTemp) async {
    if (kDebugMode) {
      print('posted: $minTemp $maxTemp');
    }
    return await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Future<AuthStatus> auth(
      {required String username, required String password}) async {
    return await Future.delayed(
        const Duration(seconds: 1), () => AuthStatus(Status.admin));
  }
}
