import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/pose/bindings/pose_binding.dart';
import '../modules/pose/views/pose_view.dart';
import '../modules/pose_description/bindings/pose_description_binding.dart';
import '../modules/pose_description/views/pose_description_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.POSE,
      page: () => const PoseView(),
      binding: PoseBinding(),
    ),
    GetPage(
      name: _Paths.POSE_DESCRIPTION,
      page: () => const PoseDescriptionView(),
      binding: PoseDescriptionBinding(),
    ),
  ];
}
