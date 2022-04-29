import 'dart:io';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:masscoinex/controllers/kyc/document_controller.dart';
import 'package:masscoinex/controllers/registration_details_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';
import 'component/continue_button.dart';

class DocumentScreen extends StatelessWidget {
  final _documentController = Get.put(RegDocumentController());
  final RegistrationDetailsController registrationDetailsController;
  final _logger = Logger();
  DocumentScreen({Key? key, required this.registrationDetailsController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(2.h),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                _dropDown(),
                SizedBox(
                  height: 2.h,
                ),
                _text(),
                SizedBox(
                  height: 5.h,
                ),
                _upload(() {
                  _documentController.pickFrontSize();
                }),
                SizedBox(
                  height: 1.h,
                ),
                Text("Upload front side"),
                SizedBox(
                  height: 10.h,
                ),
                _upload2(() {
                  _documentController.pickFrontSize2();
                }),
                SizedBox(
                  height: 1.h,
                ),
                Text("Upload back side"),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            ContinueButton(
              index: 0,
              registrationDetailsController: registrationDetailsController,
              voidCallback: () {
                _logger.d(
                    "${_documentController.isPicked.value} and ${_documentController.isPicked2.value}");
                if (_documentController.isPicked.value == true &&
                    _documentController.isPicked2.value == true) {
                  _logger.d(
                      "Document ${_documentController.isPicked.value} and ${_documentController.isPicked2.value}");
                  registrationDetailsController.uploadImageFront.value =
                      _documentController.image.value;
                  registrationDetailsController.uploadImageBack.value =
                      _documentController.image2.value;
                  registrationDetailsController.isFrontAndBackSelected.value =
                      true;
                  registrationDetailsController.uploadDocType.value =
                      _documentController.dropdownValue.value;
                } else {
                  registrationDetailsController.isFrontAndBackSelected.value =
                      false;
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _upload(VoidCallback voidCallback) {
    return Obx(
      () => SizedBox(
        child: _documentController.isPicked.value == false
            ? Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.h),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 0.1.h,
                        color: Colors.grey,
                      ),
                    ),
                    padding: EdgeInsets.all(2.h),
                    child: Icon(
                      Icons.add,
                      color: Colors.blue.shade600,
                    ),
                  ),
                  onTap: voidCallback,
                ),
              )
            : Image.file(
                File(
                  _documentController.image.value.path,
                ),
              ),
      ),
    );
  }

  Widget _upload2(VoidCallback voidCallback) {
    return Obx(
      () => SizedBox(
        child: _documentController.isPicked2.value == false
            ? Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.h),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 0.1.h,
                        color: Colors.grey,
                      ),
                    ),
                    padding: EdgeInsets.all(2.h),
                    child: Icon(
                      Icons.add,
                      color: Colors.blue.shade600,
                    ),
                  ),
                  onTap: voidCallback,
                ),
              )
            : Image.file(
                File(
                  _documentController.image2.value.path,
                ),
              ),
      ),
    );
  }

  Container _text() {
    return Container(
      width: double.infinity,
      child: Text(
        "Please upload any ID Document from the list",
        style: TextStyle(
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _dropDown() {
    return Obx(
      () => Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(
            5.h,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 2.h),
        child: DropdownButton<String>(
          isExpanded: true,
          underline: SizedBox(),
          value: _documentController.dropdownValue.value,
          onChanged: (String? newValue) {
            _documentController.dropdownValue.value = newValue!;
            //print(registrationDetailsController.currentIndex.value);
          },
          items: <String>['PAN Card', 'Aadhar Card', 'Driving Licence']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
