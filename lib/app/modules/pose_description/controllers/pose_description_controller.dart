import 'package:fit_track/app/common/yoga_pose.dart';
import 'package:fit_track/app/routes/app_pages.dart';
import 'package:get/get.dart';

class PoseDescriptionController extends GetxController {
  late final Rx<YogaPose> pose;

  final seconds = 59.0.obs;

  @override
  void onInit() {
    super.onInit();

    pose = (Get.arguments as YogaPose).obs;
  }

  void onChange(double value) {
    seconds.value = value;
  }

  void onStartClick() {
    Get.toNamed(Routes.POSE, arguments: pose.value, parameters: {
      'seconds': seconds.value.toInt().toString(),
    });
  }
}
