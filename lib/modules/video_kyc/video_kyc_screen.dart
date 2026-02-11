// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import '../../app/routes.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/enums/app_button_enum.dart';
import '../../widgets/app_button.dart';
import '../../widgets/dashed_circle_border.dart';
import 'video_kyc_controller.dart';

class VideoKycScreen extends StatelessWidget {
  VideoKycScreen({super.key});

  final controller = Get.put(VideoKycController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white100,
      body: SafeArea(
        child: Obx(() {
          /// 📋 STEP 1 — Instruction Screen
          if (!controller.showCamera.value) {
            return _instructionScreen();
          }

          /// ⏳ Loading Camera
          if (!controller.isCameraInitialized.value) {
            return const Center(child: CircularProgressIndicator());
          }

          /// 📷 STEP 2 — Camera Screen
          return _cameraScreen();
        }),
      ),
    );
  }

  // --------------------------------------------------
  // INSTRUCTION SCREEN
  // --------------------------------------------------
  Widget _instructionScreen() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _backButton(),
                const SizedBox(height: 24),

                Text("Video KYC Verification", style: AppTextStyles.h3SemiBold),
                const SizedBox(height: 6),
                Text(
                  "Complete a short video verification to finish your KYC.",
                  style: AppTextStyles.body4Regular,
                ),

                // Show video card if recorded, otherwise show profile circle
                Obx(() {
                  if (controller.recordedVideo.value != null) {
                    return Column(
                      children: [SizedBox(height: 16), _videoRecordedCard()],
                    );
                  }
                  return SizedBox();
                }),

                const SizedBox(height: 32),

                // Before you start section
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.grey50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Before you start",
                        style: AppTextStyles.body3SemiBold,
                      ),
                      const SizedBox(height: 16),
                      _checklistItem("You are in a well-lit area"),
                      const SizedBox(height: 12),
                      _checklistItem("Your face is clearly visible"),
                      const SizedBox(height: 12),
                      _checklistItem("No mask, cap, or sunglasses"),
                      const SizedBox(height: 12),
                      _checklistItem("Keep Aadhaar / PAN nearby"),
                      const SizedBox(height: 12),
                      _checklistItem("Stable internet connection"),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                Center(
                  child: Text(
                    "This process takes less than 2 minutes",
                    style: AppTextStyles.body5Regular.copyWith(
                      color: AppColors.grey400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Bottom Button
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
          child: Obx(() {
            // If video is recorded, show different button options
            if (controller.recordedVideo.value != null) {
              return Row(
                children: [
                  Expanded(
                    child: AppButton(
                      title: "Retake Video",
                      variant: AppButtonVariant.secondary,
                      state: AppButtonState.enabled,
                      onPressed: () {
                        controller.retake();
                        controller.openCamera();
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppButton(
                      title: "Continue",
                      variant: AppButtonVariant.fill,
                      state: AppButtonState.enabled,
                      onPressed: () {
                        Get.toNamed(Routes.kycCompleted);
                      },
                    ),
                  ),
                ],
              );
            }

            // Default: Start Video KYC button
            return AppButton(
              title: "Start Video KYC",
              variant: AppButtonVariant.fill,
              state: AppButtonState.enabled,
              onPressed: controller.openCamera,
            );
          }),
        ),
      ],
    );
  }

  // --------------------------------------------------
  // CAMERA SCREEN
  // --------------------------------------------------
  Widget _cameraScreen() {
    return Obx(() {
      return Stack(
        children: [
          // Camera Preview
          Positioned.fill(child: CameraPreview(controller.cameraController!)),

          // Face Circle Overlay
          Center(
            child: SizedBox(
              width: 260,
              height: 260,
              child: DashedCircleBorder(
                size: 260,
                color: Colors.white.withOpacity(0.8),
                strokeWidth: 2,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
          ),

          // Recording Indicator
          if (controller.isRecording.value)
            Positioned(
              top: 40,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Recording...",
                        style: AppTextStyles.body5SemiBold.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // Bottom Controls
          if (controller.recordedVideo.value == null)
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    if (controller.isRecording.value) {
                      controller.stopRecording();
                    } else {
                      controller.startRecording();
                    }
                  },
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: controller.isRecording.value
                          ? Colors.red
                          : Colors.white,
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                    child: Icon(
                      controller.isRecording.value
                          ? Icons.stop
                          : Icons.videocam,
                      color: controller.isRecording.value
                          ? Colors.white
                          : Colors.red,
                      size: 36,
                    ),
                  ),
                ),
              ),
            ),

          // After Recording — Show Confirm / Retake
          if (controller.recordedVideo.value != null)
            Positioned(
              bottom: 40,
              left: 20,
              right: 20,
              child: Row(
                children: [
                  Expanded(
                    child: AppButton(
                      title: "Retake",
                      variant: AppButtonVariant.secondary,
                      state: AppButtonState.enabled,
                      onPressed: controller.retake,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppButton(
                      title: "Submit",
                      variant: AppButtonVariant.fill,
                      state: AppButtonState.enabled,
                      onPressed: controller.confirmVideo,
                    ),
                  ),
                ],
              ),
            ),
        ],
      );
    });
  }

  // --------------------------------------------------
  // CHECKLIST ITEM
  // --------------------------------------------------
  Widget _checklistItem(String text) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary500,
          ),
          child: const Icon(Icons.check, color: Colors.white, size: 16),
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(text, style: AppTextStyles.body4Regular)),
      ],
    );
  }

  // --------------------------------------------------
  // BACK BUTTON
  // --------------------------------------------------
  Widget _backButton() {
    return InkWell(
      onTap: () => Get.back(),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey100),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.arrow_back_ios_new, size: 18),
      ),
    );
  }

  // --------------------------------------------------
  // VIDEO RECORDED CARD
  // --------------------------------------------------
  Widget _videoRecordedCard() {
    final fileName = controller.recordedVideo.value!.path.split('/').last;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey100, width: 1),
      ),
      child: Column(
        children: [
          // File icon and name
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.videocam,
                  color: AppColors.primary500,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fileName,
                      style: AppTextStyles.body4SemiBold,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Video KYC Recording",
                      style: AppTextStyles.body5Regular.copyWith(
                        color: AppColors.grey400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Verified Successfully
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.green500,
                ),
                child: const Icon(
                  Icons.check,
                  color: AppColors.white100,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "Verified Successfully",
                style: AppTextStyles.body3SemiBold.copyWith(
                  color: AppColors.green500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
