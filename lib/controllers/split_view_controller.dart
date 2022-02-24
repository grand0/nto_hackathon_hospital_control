import 'package:get/get.dart';

class SplitViewController extends GetxController {
  final _split = false.obs;

  bool get split => _split.value;
  void toggleSplit() => _split.toggle();
}