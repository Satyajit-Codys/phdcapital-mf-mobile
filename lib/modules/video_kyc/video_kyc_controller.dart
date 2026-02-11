import 'dart:io';
import 'package:camera/camera.dart';
import 'package:get/get.dart';

class VideoKycController extends GetxController {
  CameraController? cameraController;

  final RxBool showCamera = false.obs;
  final RxBool isCameraInitialized = false.obs;
  final RxBool isRecording = false.obs;
  final Rx<File?> recordedVideo = Rx<File?>(null);

  Future<void> initCamera() async {
    final cameras = await availableCameras();

    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
    );

    cameraController = CameraController(
      frontCamera,
      ResolutionPreset.medium,
      enableAudio: true,
    );

    await cameraController!.initialize();
    isCameraInitialized.value = true;
  }

  void openCamera() async {
    showCamera.value = true;
    await initCamera();
  }

  Future<void> startRecording() async {
    if (cameraController == null || !cameraController!.value.isInitialized)
      return;

    await cameraController!.startVideoRecording();
    isRecording.value = true;
  }

  Future<void> stopRecording() async {
    if (!isRecording.value) return;

    final XFile file = await cameraController!.stopVideoRecording();
    isRecording.value = false;
    recordedVideo.value = File(file.path);
  }

  void retake() {
    recordedVideo.value = null;
  }

  void confirmVideo() {
    // Close camera and go back to instruction screen
    showCamera.value = false;
    isCameraInitialized.value = false;
    cameraController?.dispose();
    cameraController = null;

    // TODO: Upload API
    Get.snackbar("Success", "Video captured successfully");
  }

  @override
  void onClose() {
    cameraController?.dispose();
    super.onClose();
  }
}
