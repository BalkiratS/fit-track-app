import 'package:fit_track/app/common/yoga_pose.dart';
import 'package:fit_track/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  static const _widgets = [
    Home(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Fit Track",
          style: GoogleFonts.ubuntu(),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Obx(() => _widgets[controller.selectedIndex.value]),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      for (var pose in yogaPoses)
        PoseCard(
          yogaPose: pose,
        ),
    ]);
  }
}

class PoseCard extends StatelessWidget {
  const PoseCard({
    super.key,
    required this.yogaPose,
  });

  final YogaPose yogaPose;
  static const _size = 175.0;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: InkWell(
        splashColor: Colors.deepOrange.withOpacity(0.3),
        onTap: yogaPose.modelFile.isNotEmpty
            ? () => Get.toNamed(
                  Routes.POSE_DESCRIPTION,
                  arguments: yogaPose,
                )
            // If the model file not present for the pose, set it to empty function body.
            : () {},
        child: Row(
          children: [
            Image.asset(yogaPose.imageFile, width: _size, height: _size),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      yogaPose.name,
                      style: GoogleFonts.ubuntu(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      yogaPose.description,
                      style: GoogleFonts.ubuntu(
                        color: Colors.grey,
                      ),
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
