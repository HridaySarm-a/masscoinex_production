import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:masscoinex/api/api_routes.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:masscoinex/models/profile_model.dart';
import 'package:masscoinex/models/user_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class ProfileScreen extends StatelessWidget {
  final _box = Hive.box(GlobalVals.hiveBox);
  final _fullnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _referralController = TextEditingController();
  final _phoneController = TextEditingController();
  final _pinController = TextEditingController();
  final _countryController = TextEditingController();
  final _stateController = TextEditingController();
  final _cityController = TextEditingController();
  final _postCodeController = TextEditingController();
  final _addressController = TextEditingController();
  final _selectedDate = DateTime.now().obs;
  final isUpdated = true.obs;
  final _logger = Logger();
  final image = XFile("").obs;
  final isPicked = false.obs;
  final isImageClicked = false.obs;
  final _imageNetwork = "".obs;

  @override
  Widget build(BuildContext context) {
    //handleAppLifecycleState();
    final _profileInfo =
        ProfileModel.fromJson(json.decode(_box.get(GlobalVals.profileInfo)));
    final _result = _profileInfo.result;
    _fullnameController.text = _result.fullName;
    _emailController.text = _result.email;
    _referralController.text = _result.referralCode ?? "";
    _phoneController.text = _result.phone;
    _pinController.text = _result.pin;
    _countryController.text = _result.country;
    _stateController.text = _result.state;
    _cityController.text = _result.city;
    _postCodeController.text = _result.postcode;
    _addressController.text = _result.address ?? "";
    _imageNetwork.value = "${_result.imageName}";
    final _date = DateFormat("yyyy-MM-dd").format(DateTime.now());
    _selectedDate.value =
        DateFormat("yyyy-MM-dd").parse(_result.dob == "" ? _date : _result.dob);
    return Container(
      color: GlobalVals.appbarColor,
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 800,
            ),
            Positioned(
              top: 5.h,
              child: Container(
                width: 90.w,
                padding: EdgeInsets.all(2.h),
                margin: EdgeInsets.all(2.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.h),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 3.h,
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "${_profileInfo.result.fullName}\n",
                            style: TextStyle(
                              color: GlobalVals.appbarColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: "${_profileInfo.result.email}\n",
                            style: TextStyle(
                              color: GlobalVals.appbarColor,
                              fontSize: 14.sp,
                            ),
                          ),
                          TextSpan(
                            text:
                                "User ID: ${(_profileInfo.result.referralCode != null ? _profileInfo.result.referralCode : "")}\n",
                            style: TextStyle(
                              color: GlobalVals.appbarColor,
                              fontSize: 14.sp,
                            ),
                          ),
                          TextSpan(
                            text: "Country: ${_profileInfo.result.country}",
                            style: TextStyle(
                              color: GlobalVals.appbarColor,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    _textFields("Full Name", _fullnameController,
                        TextInputType.name, true),
                    SizedBox(
                      height: 2.h,
                    ),
                    _textFields("Email", _emailController,
                        TextInputType.emailAddress, false),
                    SizedBox(
                      height: 2.h,
                    ),
                    _textFields("Referral Code", _referralController,
                        TextInputType.text, false),
                    SizedBox(
                      height: 2.h,
                    ),
                    //_textFields("Date of Birth"),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(
                          5.h,
                        ),
                        child: Container(
                          height: 4.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              5.h,
                            ),
                            border: Border.all(
                              width: 0.2.h,
                              color: Colors.grey.shade400,
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Obx(
                              () => Text(
                                "     ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          _selectDate(context);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    _textFields(
                        "Phone", _phoneController, TextInputType.phone, true),
                    SizedBox(
                      height: 2.h,
                    ),
                    _textFields(
                        "Pin", _pinController, TextInputType.number, true),
                    SizedBox(
                      height: 2.h,
                    ),
                    _textFields(
                        "State", _stateController, TextInputType.name, true),
                    SizedBox(
                      height: 2.h,
                    ),
                    _textFields(
                        "City", _cityController, TextInputType.name, true),
                    SizedBox(
                      height: 2.h,
                    ),
                    _textFields("Post Code", _postCodeController,
                        TextInputType.name, true),
                    SizedBox(
                      height: 2.h,
                    ),
                    _textFields("Address", _addressController,
                        TextInputType.name, true),
                    SizedBox(
                      height: 2.h,
                    ),
                    _textFields("Country", _countryController,
                        TextInputType.name, false),
                    SizedBox(height: 2.h),
                    Container(
                      width: double.infinity,
                      child: Obx(
                        () => ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              GlobalVals.buttonColor,
                            ),
                            elevation: MaterialStateProperty.all(0),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  5.h,
                                ),
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (_fullnameController.text.isEmpty ||
                                _postCodeController.text.isEmpty ||
                                _phoneController.text.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "Fill all the fields",
                                  backgroundColor: Colors.red);
                            } else {
                              updateProfile();
                            }
                          },
                          child: isUpdated.value == true
                              ? Text("Update")
                              : CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                child: Center(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(
                        5.h,
                      ),
                      child: Stack(
                        children: [
                          Card(
                            elevation: 1.h,
                            shape: CircleBorder(
                              side: BorderSide(
                                width: 0.5.h,
                                color: Colors.white,
                              ),
                            ),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Obx(
                                () => ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    5.h,
                                  ),
                                  child: isImageClicked.value == true
                                      ? Image.file(
                                          File(
                                            image.value.path,
                                          ),
                                          fit: BoxFit.cover,
                                        )
                                      : Image.network(
                                          _imageNetwork.value,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                              radius: 5.h,
                            ),
                          ),
                          Positioned(
                            bottom: 1.h,
                            right: 1.h,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.all(0.4.h),
                              child: Icon(
                                Icons.add_a_photo,
                                size: 2.h,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        pickImageSize();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _textFields(
      String text,
      TextEditingController textEditingController,
      TextInputType textInputType,
      bool canEdit) {
    return Container(
      height: 4.h,
      width: double.infinity,
      child: TextField(
        enabled: canEdit,
        controller: textEditingController,
        keyboardType: textInputType,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              5.h,
            ),
            gapPadding: 1.0,
          ),
          hintText: text,
          focusColor: Colors.blue,
          contentPadding: EdgeInsets.symmetric(
            vertical: 1.h,
            horizontal: 2.h,
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate.value,
        firstDate: DateTime(1900, 1),
        lastDate: DateTime(2101));
    if (picked != null && picked != _selectedDate.value)
      _selectedDate.value = picked;
  }

  updateProfilePicture() async {
    Get.defaultDialog(
      barrierDismissible: false,
      title: "Your picture is uploading",
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Please wait.."),
          SizedBox(
            width: 5.w,
          ),
          CircularProgressIndicator(
            color: Colors.blue,
          ),
        ],
      ),
    );
    final _userInfo =
        UserModel.fromJson(json.decode(_box.get(GlobalVals.user)));
    final _token = _userInfo.result.token;
    var _request = new http.MultipartRequest(
        "POST", Uri.parse(ApiRoutes.baseUrl + ApiRoutes.updatePhoto));
    Map<String, String> _header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };
    var _profileStream = new http.ByteStream(image.value.openRead()..cast());
    var _profileLength = await image.value.length();
    var _profileFile = new http.MultipartFile(
        'image_path', _profileStream, _profileLength,
        filename: basename(image.value.path));
    _request.files.add(_profileFile);
    _request.headers.addAll(_header);
    var _response = await _request.send();
    _logger.d(_response.statusCode);
    _response.stream.transform(utf8.decoder).listen((event) {
      isPicked.value = false;
      _logger.d("event: $event");
      Get.back();
      getProfileInfo();
      Fluttertoast.showToast(
          msg: "Profile Info Updated", backgroundColor: Colors.green);
      _logger.d(event);
    });
  }

  updateProfile() async {
    isUpdated.value = false;
    final _userInfo =
        UserModel.fromJson(json.decode(_box.get(GlobalVals.user)));
    final _token = _userInfo.result.token;
    Map<String, String> _header = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };
    final Map<String, dynamic> _body = {
      "full_name": _fullnameController.text,
      "postcode": _postCodeController.text,
      "dob":
          "${_selectedDate.value.year}-${_selectedDate.value.month}-${_selectedDate.value.day}",
      "phone": _phoneController.text,
      "terms": "1",
    };
    var _response = await http.post(
        Uri.parse(ApiRoutes.baseUrl + ApiRoutes.profileUpdate),
        body: _body,
        headers: _header);
    _logger.d(_response.body);
    if (_response.statusCode == 200) {
      isUpdated.value = true;
      Fluttertoast.showToast(
          msg: "Profile Info Updated", backgroundColor: Colors.green);
      _box.put(GlobalVals.profileInfo, _response.body);
    } else {
      isUpdated.value = true;
      Fluttertoast.showToast(
          msg: "Update Error: ${_response.statusCode}",
          backgroundColor: Colors.red);
    }
  }

  pickImageSize() {
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
              isImageClicked.value = true;
              final ImagePicker _picker = ImagePicker();
              final XFile? photo =
                  await _picker.pickImage(source: ImageSource.gallery);
              /*var _getGalleryImage =
                  await _picker.pickImage(source: ImageSource.gallery);*/
              if (photo != null) {
                isPicked.value = true;
                image.value = photo;
                isImageClicked.value = false;
                Get.back();
                updateProfilePicture();
              } else {
                Get.back();
              }
              /*if (_getGalleryImage != null) {
                isPicked.value = true;
                image.value = _getGalleryImage;
              } else {
                isPicked.value = false;
                image.value = XFile("");
              }*/
            },
          ),
          ListTile(
            title: Text("Capture image"),
            leading: Icon(
              Icons.camera_rounded,
              color: Colors.blue,
            ),
            onTap: () async {
              isImageClicked.value = true;
              final ImagePicker _picker = ImagePicker();
              final XFile? photo =
                  await _picker.pickImage(source: ImageSource.camera);
              /*var _getGalleryImage =
              await _picker.pickImage(source: ImageSource.gallery);*/
              if (photo != null) {
                isPicked.value = true;
                image.value = photo;
                isImageClicked.value = false;
                Get.back();
                updateProfilePicture();
              } else {
                Get.back();
              }

              /*isImageClicked.value = true;
              var _getGalleryImage =
                  await _picker.pickImage(source: ImageSource.camera);
              if (_getGalleryImage != null) {
                _logger.d("isPicked: if ${isPicked.value}");
                isPicked.value = true;
                image.value = _getGalleryImage;
              } else {
                _logger.d("isPicked: else ${isPicked.value}");
                isPicked.value = false;
                image.value = XFile("");
              }*/
            },
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }

  /*handleAppLifecycleState() {
    SystemChannels.lifecycle.setMessageHandler((msg) {
      print('SystemChannels> $msg');
      _logger.d('SystemChannels> $msg');

      switch (msg) {
        case "AppLifecycleState.paused":
          break;
        case "AppLifecycleState.inactive":
          break;
        case "AppLifecycleState.resumed":
          Future.delayed(Duration(milliseconds: 500), () {
            _logger.d("isPicked: ${isPicked.value}");
            if (isImageClicked.value == true) {
              //Get.back();
              isImageClicked.value = false;
              if (isPicked.value == true) {
                updateProfilePicture();
              }
            }
          });
          break;
        case "AppLifecycleState.suspending":
          break;
        default:
      }
      return Future.value("");
    });
  }*/

  getProfileInfo() async {
    final _box = await Hive.openBox(GlobalVals.hiveBox);
    final _userInfo =
        UserModel.fromJson(json.decode(_box.get(GlobalVals.user)));
    final _token = _userInfo.result.token;
    Map<String, String> _header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };
    final _response = await http.get(
      Uri.parse(ApiRoutes.baseUrl + ApiRoutes.profileInfo),
      headers: _header,
    );
    _logger.d(_response.body);
    if (_response.statusCode == 200) {
      var _result = profileModelFromJson(_response.body);
      _imageNetwork.value = _result.result.imageName;
      _box.put(GlobalVals.profileInfo, _response.body);
    } else {
      GlobalVals.errorToast("Server Error");
    }
  }
}
