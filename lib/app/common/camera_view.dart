import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraView extends StatefulWidget {
  const CameraView({
    super.key,
    required this.processImageStream,
  });

  final dynamic Function(CameraImage) processImageStream;

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late final CameraController controller;
  List<CameraDescription>? cameras;

  @override
  void initState() {
    availableCameras().then((_) {
      setState(() {
        cameras = _;

        controller = CameraController(
          cameras![1],
          ResolutionPreset.high,
          imageFormatGroup: ImageFormatGroup.yuv420,
        );

        controller.initialize().then((_) {
          if (!mounted) {
            return;
          }

          controller.startImageStream(widget.processImageStream);
          setState(() {});
        });
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (cameras == null || !controller.value.isInitialized) {
      return Container();
    }

    return CameraPreview(
      controller,
    );
  }
}
