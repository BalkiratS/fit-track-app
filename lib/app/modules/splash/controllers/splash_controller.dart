import 'package:fit_track/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  /// Duration is the minimum number of seconds the splash screen will be shown.
  static const _duration = 5;

  @override
  Future<void> onInit() async {
    await Future.delayed(const Duration(seconds: _duration), () => true);

    Get.offNamed(Routes.HOME);
    super.onInit();
  }
}
