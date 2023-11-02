import 'package:fit_track/app/common/background.dart';
import 'package:fit_track/app/common/title_card.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

/// Initial view for the application. Provides time to verify user authorization.
class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Background(
        child: Center(
          child: TitleCard(
            children: [],
          ),
        ),
      ),
    );
  }
}
