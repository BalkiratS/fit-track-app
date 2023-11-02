import 'package:get/get.dart';

class HomeController extends GetxController {
  final selectedIndex = 0.obs;

  @override
  void onInit() async {
    super.onInit();
  }

  void onItemTap(int index) {
    selectedIndex.value = index;
  }
}
