import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SelfieIdController extends GetxController {
  var image = XFile("").obs;
  var isPicked = false.obs;

  pickFrontSize() {
    final _picker = ImagePicker();
    Get.defaultDialog(
      title: "Choose Option",
      middleText: "Pick one of the option to pick",
      content: Column(
        children: [
          ListTile(
            title: Text("Choose from gallery"),
            leading: Icon(
              Icons.photo_size_select_actual_rounded,
              color: Colors.blue,
            ),
            onTap: () async {
              var _getGalleryImage =
                  await _picker.pickImage(source: ImageSource.gallery);
              if (_getGalleryImage != null) {
                isPicked.value = true;
                image.value = _getGalleryImage;
              } else {
                isPicked.value = false;
                image.value = XFile("");
              }
            },
          ),
          ListTile(
            title: Text("Capture image"),
            leading: Icon(
              Icons.camera_rounded,
              color: Colors.blue,
            ),
            onTap: () async {
              var _getGalleryImage =
                  await _picker.pickImage(source: ImageSource.camera);
              if (_getGalleryImage != null) {
                isPicked.value = true;
                image.value = _getGalleryImage;
              } else {
                isPicked.value = false;
                image.value = XFile("");
              }
            },
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }
}
