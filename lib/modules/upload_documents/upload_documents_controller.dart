import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

enum DocumentType { pan, address, photo, signature }

class UploadDocumentsController extends GetxController {
  final ImagePicker _picker = ImagePicker();

  final RxBool isFormValid = false.obs;

  /// Stores actual uploaded files
  final uploadedDocs = <DocumentType, File?>{}.obs;

  // -----------------------------------------------------------
  // PICK DOCUMENT
  // -----------------------------------------------------------

  void pickDocument(DocumentType type) {
    Get.bottomSheet(
      _uploadOptions(type),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
    );
  }

  // -----------------------------------------------------------
  // BOTTOM SHEET OPTIONS
  // -----------------------------------------------------------

  Widget _uploadOptions(DocumentType type) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _option(
            icon: Icons.camera_alt,
            title: "Take Photo",
            onTap: () async {
              final image = await _picker.pickImage(
                source: ImageSource.camera,
                imageQuality: 80, // compress image
              );

              if (image != null) {
                final file = File(image.path);

                if (_isValidSize(file)) {
                  uploadedDocs[type] = file; // replaces if exists
                  _validate();
                } else {
                  Get.snackbar(
                    "File too large",
                    "Maximum file size is 5MB",
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              }

              Get.back();
            },
          ),
          _option(
            icon: Icons.photo,
            title: "Choose from Gallery",
            onTap: () async {
              final image = await _picker.pickImage(
                source: ImageSource.gallery,
                imageQuality: 80,
              );

              if (image != null) {
                final file = File(image.path);

                if (_isValidSize(file)) {
                  uploadedDocs[type] = file;
                  _validate();
                } else {
                  Get.snackbar(
                    "File too large",
                    "Maximum file size is 5MB",
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              }

              Get.back();
            },
          ),
          _option(
            icon: Icons.insert_drive_file,
            title: "Choose File",
            onTap: () async {
              final result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
              );

              if (result != null) {
                final path = result.files.single.path;

                if (path != null) {
                  final file = File(path);

                  if (_isValidSize(file)) {
                    uploadedDocs[type] = file;
                    _validate();
                  } else {
                    Get.snackbar(
                      "File too large",
                      "Maximum file size is 5MB",
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                }
              }

              Get.back();
            },
          ),
        ],
      ),
    );
  }

  // -----------------------------------------------------------
  // OPTION TILE
  // -----------------------------------------------------------

  Widget _option({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(leading: Icon(icon), title: Text(title), onTap: onTap);
  }

  // -----------------------------------------------------------
  // REMOVE DOCUMENT
  // -----------------------------------------------------------

  void removeDocument(DocumentType type) {
    uploadedDocs[type] = null;
    _validate();
  }

  // -----------------------------------------------------------
  // FILE SIZE VALIDATION (MAX 5MB)
  // -----------------------------------------------------------

  bool _isValidSize(File file) {
    final sizeInBytes = file.lengthSync();
    final sizeInMB = sizeInBytes / (1024 * 1024);
    return sizeInMB <= 5;
  }

  // -----------------------------------------------------------
  // FORM VALIDATION
  // -----------------------------------------------------------

  void _validate() {
    isFormValid.value =
        uploadedDocs.values.where((file) => file != null).length == 4;
  }
}
