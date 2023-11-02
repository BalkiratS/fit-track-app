import 'package:get/get.dart';

import '../controllers/pose_description_controller.dart';

class PoseDescriptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PoseDescriptionController>(
      () => PoseDescriptionController(),
    );
  }
}
