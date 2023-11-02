import 'package:get/get.dart';

import '../controllers/pose_controller.dart';

class PoseBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      PoseController(),
    );
  }
}
