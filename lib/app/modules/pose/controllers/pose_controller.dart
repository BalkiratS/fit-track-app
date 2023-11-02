import 'dart:async';

import 'package:camera/camera.dart';
import 'package:fit_track/app/api/api.dart';
import 'package:fit_track/app/common/yoga_pose.dart';
import 'package:fit_track/app/routes/app_pages.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

class PoseController extends GetxController {
  final PoseDetector _poseDetector = PoseDetector(
    options: PoseDetectorOptions(
      model: PoseDetectionModel.accurate,
      mode: PoseDetectionMode.single,
    ),
  );

  late final Interpreter _interpreter;

  late final Rx<YogaPose> pose;
  late final Rx<int> time;

  /// Time is to keep track of timer in seconds.
  final score = 0.0.obs;

  /// Define when the user does the pose correctly for first time.
  final firstCorrectPose = false.obs;

  /// Render overlay to show the user correctly started the excercise.
  final renderOverlay = false.obs;

  var _isBusy = false;

  @override
  Future<void> onInit() async {
    super.onInit();
    pose = (Get.arguments as YogaPose).obs;
    time = int.parse(Get.parameters['seconds']!).obs;

    _interpreter = await Interpreter.fromAsset(pose().modelFile);
    _interpreter.allocateTensors();
  }

  Future<void> processImageStream(CameraImage image) async {
    final allBytes = WriteBuffer();
    for (final Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }

    final bytes = allBytes.done().buffer.asUint8List();

    final imageSize = Size(image.width.toDouble(), image.height.toDouble());

    final camera = (await availableCameras())[1];
    final imageRotation =
        InputImageRotationValue.fromRawValue(camera.sensorOrientation);
    if (imageRotation == null) return;

    final inputImageFormat =
        InputImageFormatValue.fromRawValue(image.format.raw);
    if (inputImageFormat == null) return;

    final planeData = image.planes.map(
      (Plane plane) {
        return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      },
    ).toList();

    final inputImageData = InputImageData(
      size: imageSize,
      imageRotation: imageRotation,
      inputImageFormat: inputImageFormat,
      planeData: planeData,
    );

    final inputImage =
        InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);

    runInterpreter(
      inputImage,
      imageRotation,
      imageSize,
      inputImage.inputImageData!.size,
    );
  }

  double translateX(double x, Size size) {
    return x / size.width;
  }

  double translateY(double y, Size size) {
    return y / size.height;
  }

  Future<void> runInterpreter(
    InputImage inputImage,
    InputImageRotation rotation,
    Size size,
    Size absoluteImageSize,
  ) async {
    if (_isBusy) return;
    _isBusy = true;
    final poses = await _poseDetector.processImage(inputImage);

    for (final pose in poses) {
      var nose = pose.landmarks[PoseLandmarkType.nose]!;
      var leftShoulder = pose.landmarks[PoseLandmarkType.leftShoulder]!;
      var rightShoudler = pose.landmarks[PoseLandmarkType.rightShoulder]!;
      var leftElbow = pose.landmarks[PoseLandmarkType.leftElbow]!;
      var rightElbow = pose.landmarks[PoseLandmarkType.rightElbow]!;
      var leftWrist = pose.landmarks[PoseLandmarkType.leftWrist]!;
      var rightWrist = pose.landmarks[PoseLandmarkType.rightWrist]!;
      var leftHip = pose.landmarks[PoseLandmarkType.leftHip]!;
      var rightHip = pose.landmarks[PoseLandmarkType.rightHip]!;
      var leftKnee = pose.landmarks[PoseLandmarkType.leftKnee]!;
      var rightKnee = pose.landmarks[PoseLandmarkType.rightKnee]!;
      var leftAnkle = pose.landmarks[PoseLandmarkType.leftAnkle]!;
      var rightAnkle = pose.landmarks[PoseLandmarkType.rightAnkle]!;

      var inputData = [
        translateX(nose.x, absoluteImageSize),
        translateY(nose.y, absoluteImageSize),
        nose.likelihood,
        translateX(leftShoulder.x, absoluteImageSize),
        translateY(leftShoulder.y, absoluteImageSize),
        leftShoulder.likelihood,
        translateX(rightShoudler.x, absoluteImageSize),
        translateY(rightShoudler.y, absoluteImageSize),
        rightShoudler.likelihood,
        translateX(leftElbow.x, absoluteImageSize),
        translateY(leftElbow.y, absoluteImageSize),
        leftElbow.likelihood,
        translateX(rightElbow.x, absoluteImageSize),
        translateX(rightElbow.y, absoluteImageSize),
        rightElbow.likelihood,
        translateX(leftWrist.x, absoluteImageSize),
        translateY(leftWrist.y, absoluteImageSize),
        leftWrist.likelihood,
        translateX(rightWrist.x, absoluteImageSize),
        translateY(rightWrist.y, absoluteImageSize),
        rightWrist.likelihood,
        translateX(leftHip.x, absoluteImageSize),
        translateY(leftHip.y, absoluteImageSize),
        leftHip.likelihood,
        translateX(rightHip.x, absoluteImageSize),
        translateY(rightHip.y, absoluteImageSize),
        rightHip.likelihood,
        translateX(leftKnee.x, absoluteImageSize),
        translateY(leftKnee.y, absoluteImageSize),
        leftKnee.likelihood,
        translateX(rightKnee.x, absoluteImageSize),
        translateY(rightKnee.y, absoluteImageSize),
        rightKnee.likelihood,
        translateX(leftAnkle.x, absoluteImageSize),
        translateY(leftAnkle.y, absoluteImageSize),
        leftAnkle.likelihood,
        translateX(rightAnkle.x, absoluteImageSize),
        translateY(rightAnkle.y, absoluteImageSize),
        rightAnkle.likelihood,
      ];

      List<List<double>> input = [inputData];
      List<List<double>> output = [
        [0],
      ];

      _interpreter.run(input, output);
      score.value = output[0][0];

      // First time the user pose is correct.
      if (score.value > this.pose.value.threshold && !firstCorrectPose.value) {
        firstCorrectPose.value = true;

        Timer.periodic(const Duration(seconds: 1), (_) async {
          if (time.value <= 0) {
            _.cancel();

            try {
              final user = await Api.getUser();

              int index = 0;
              for (var stat in user.stats) {
                if (stat['excercise'] == this.pose().name.toLowerCase()) {
                  break;
                }

                index += 1;
              }

              await Api.updateStats(
                user.stats[index]['id'],
                user.stats[index]['duration'] != null
                    ? user.stats[index]['duration'] +
                        int.parse(Get.parameters['seconds']!)
                    : int.parse(Get.parameters['seconds']!),
              );
            } finally {}

            // Only show the default dialog
            if (Get.currentRoute.split("?")[0] == Routes.POSE) {
              Get.defaultDialog(
                title: "Fit Track",
                content: Text("Successfully completed ${this.pose().name}"),
                // Redirect the user back to home.
                textConfirm: "Go Back",
                onConfirm: () => Get.offAllNamed(Routes.HOME),
              );
            }

            return;
          }

          time.value -= 1;
        });

        // Render overlay, and hide it after three seconds.
        renderOverlay.value = true;
        Timer(const Duration(seconds: 3), () => renderOverlay.value = false);
      }
    }

    _isBusy = false;
  }
}
