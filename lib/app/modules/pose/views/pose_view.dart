import 'package:fit_track/app/common/camera_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/pose_controller.dart';

class PoseView extends GetView<PoseController> {
  const PoseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!controller.initialized) {
      return Container();
    }

    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => Stack(
            children: [
              Column(
                children: [
                  _createCameraView(),
                  _createBottomBar(),
                ],
              ),
              if (controller.renderOverlay.value) _createOverlay(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createCameraView() {
    return CameraView(
      processImageStream: controller.processImageStream,
    );
  }

  Widget _createBottomBar() {
    const horizontalPad = 30.0;
    final textStyle = GoogleFonts.ubuntu(
      fontSize: 35,
      color: Colors.white,
    );

    return Expanded(
      child: Obx(
        () => Container(
          padding: const EdgeInsets.only(
            left: horizontalPad,
            right: horizontalPad,
          ),
          decoration: BoxDecoration(
            color: controller.score > controller.pose().threshold
                ? Colors.green
                : Colors.red,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(controller.pose().name, style: textStyle),
              ),
              Obx(
                () => Text("${controller.time} seconds", style: textStyle),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createOverlay() {
    const elevation = 5.0;

    return Center(
      child: Card(
        shape: const CircleBorder(),
        elevation: elevation,
        color: Colors.black.withOpacity(0.6),
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Image.asset(
            'images/correct.png',
            fit: BoxFit.contain,
            height: 200,
            width: 200,
          ),
        ),
      ),
    );
  }
}
