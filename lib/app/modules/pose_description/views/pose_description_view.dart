import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/pose_description_controller.dart';

class PoseDescriptionView extends GetView<PoseDescriptionController> {
  const PoseDescriptionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = GoogleFonts.ubuntu(
      fontSize: 22,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pose Description'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: controller.onStartClick,
        label: const Text('START'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(controller.pose().descriptionImageFile!),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                "Number of Seconds",
                style: GoogleFonts.ubuntu(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Obx(
              () => Slider(
                value: controller.seconds.value,
                min: 20,
                max: 60,
                divisions: 8,
                label: controller.seconds.value.toString(),
                onChanged: controller.onChange,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
              child: Divider(
                thickness: 2,
              ),
            ),
            for (var step in controller.pose().steps!)
              ListTile(
                leading: Text(
                  "•",
                  style: textStyle,
                ),
                title: Text(
                  step,
                  style: textStyle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
