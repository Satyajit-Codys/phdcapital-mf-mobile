import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phdcapital_mf_mobile/widgets/dashed_rounded_border.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/enums/app_button_enum.dart';
import '../../widgets/app_button.dart';
import 'upload_documents_controller.dart';

class UploadDocumentsScreen extends StatelessWidget {
  UploadDocumentsScreen({super.key});

  final controller = Get.put(UploadDocumentsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white100,

      bottomNavigationBar: Obx(
        () => Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
          child: AppButton(
            title: "Verify Document",
            variant: AppButtonVariant.fill,
            state: controller.isFormValid.value
                ? AppButtonState.enabled
                : AppButtonState.disabled,
            onPressed: controller.isFormValid.value
                ? () {
                    Get.toNamed("/video-kyc");
                  }
                : null,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _backButton(),
              const SizedBox(height: 24),

              Text("Upload Documents", style: AppTextStyles.h3SemiBold),
              const SizedBox(height: 6),
              Text(
                "Complete your KYC by uploading the required documents below.",
                style: AppTextStyles.body4Regular,
              ),

              const SizedBox(height: 24),

              _uploadCard(
                type: DocumentType.pan,
                title: "Upload PAN Card",
                subtitle: "JPG / PNG / PDF  •  Max 5MB",
                helper: "Ensure PAN details are clearly visible",
              ),

              const SizedBox(height: 12),

              _uploadCard(
                type: DocumentType.address,
                title: "Upload Address Proof",
                subtitle: "Aadhaar / Passport / Utility Bill",
                helper: "Document should match your current address",
              ),

              const SizedBox(height: 12),

              _uploadCard(
                type: DocumentType.photo,
                title: "Upload Your Photo",
                subtitle: "Clear selfie with plain background",
                helper: "No sunglasses or filters",
              ),

              const SizedBox(height: 12),

              _uploadCard(
                type: DocumentType.signature,
                title: "Upload Signature",
                subtitle: "Upload scanned signature",
                helper: "Use blue or black ink",
              ),

              const SizedBox(height: 24),
              _guidelines(),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // UPDATED CARD WITH FILE DISPLAY
  // ---------------------------------------------------------------------------

  Widget _uploadCard({
    required DocumentType type,
    required String title,
    required String subtitle,
    required String helper,
  }) {
    return Obx(() {
      final file = controller.uploadedDocs[type];

      return GestureDetector(
        onTap: () => controller.pickDocument(type),
        child: DashedRoundedBorder(
          radius: 12,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(title, style: AppTextStyles.body3SemiBold),
                const SizedBox(height: 4),
                file == null
                    ? Column(
                        children: [
                          Text(
                            subtitle,
                            style: AppTextStyles.body4Regular.copyWith(
                              color: AppColors.grey300,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            helper,
                            style: AppTextStyles.body5Regular.copyWith(
                              color: AppColors.grey300,
                            ),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.insert_drive_file, size: 28),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  file.path.split('/').last,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.body4Regular,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Uploaded",
                                style: AppTextStyles.body5Regular.copyWith(
                                  color: AppColors.green500,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => controller.removeDocument(type),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      );
    });
  }

  // ---------------------------------------------------------------------------

  Widget _guidelines() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.grey50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Upload Guidelines", style: AppTextStyles.body3SemiBold),
          const SizedBox(height: 12),
          _bullet("Document must be clear and readable"),
          _bullet("Avoid blur, glare, or cropped images"),
          _bullet("Your documents are encrypted and securely stored"),
        ],
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          const Icon(Icons.circle, size: 6, color: AppColors.primary500),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: AppTextStyles.body5Regular)),
        ],
      ),
    );
  }

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
}
