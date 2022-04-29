import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RegDocumentController extends GetxController {
  var dropdownValue = "PAN Card".obs;
  var image = XFile("").obs;
  var image2 = XFile("").obs;
  var isPicked = false.obs;
  var isPicked2 = false.obs;

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
  pickFrontSize2() {
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
                isPicked2.value = true;
                image2.value = _getGalleryImage;
              } else {
                isPicked2.value = false;
                image2.value = XFile("");
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
                isPicked2.value = true;
                image2.value = _getGalleryImage;
              } else {
                isPicked2.value = false;
                image2.value = XFile("");
              }
            },
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }
}
