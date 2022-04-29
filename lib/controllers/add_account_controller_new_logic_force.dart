import 'dart:convert';
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:masscoinex/api/api_routes.dart';
import 'package:masscoinex/global/global_vals.dart';
import 'package:masscoinex/models/card/add/add_card_fields_model.dart';
import 'package:masscoinex/models/card/add/add_card_fields_success_model.dart';
import 'package:masscoinex/routes/route_list.dart';
import 'package:path/path.dart';
import 'package:masscoinex/models/user_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';

class AddAccountControllerNewLogicForce extends GetxController {
  final currentIndex = 0.obs;
  final currentBankDetails = 1.obs;
  final currentCardDetails = 1.obs;
  final RxList<Column> addBank = [Column()].obs;
  final RxList<Column> addCard = [Column()].obs;
  var avatar = "assets/avtr.png".obs;
  var avatar2 = "assets/avtr.png".obs;
  var avatar4 = "assets/avtr.png".obs;
  var video3 = "assets/avtr.png".obs;
  var isFromAsset = true.obs;
  var isFromAsset2 = true.obs;
  var isFromAsset4 = true.obs;
  var isFromAsset3 = true.obs;
  var isUploaded = true.obs;
  var isVisible = false.obs;
  late VideoPlayerController videoPlayerController;
  var size = Size(10.h, 10.h);
  var tabBar = TabBar(
    tabs: [],
  );
  var cardScreenIndex = 0.obs;
  final _logger = Logger();
  final _box = Hive.box(GlobalVals.hiveBox);

  var isCardAdded = true.obs;

  /*Add bank text controller fields*/
  var nameOnCardController = TextEditingController();
  var billingAddressController = TextEditingController();
  var telephoneNumberController = TextEditingController();
  var countryController = TextEditingController();
  var cardNumberController = TextEditingController();
  var cardTypeController = TextEditingController();
  var cardExpiryController = TextEditingController();
  var cardCVCController = TextEditingController();

  addCardDetails() async {
    isCardAdded.value = false;
    final _userInfo =
        UserModel.fromJson(json.decode(_box.get(GlobalVals.user)));
    final _token = _userInfo.result.token;
    Map<String, String> _header = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };
    final Map<String, dynamic> _body = {
      "name_on_card": nameOnCardController.text,
      "billing_address": billingAddressController.text,
      "telephone": telephoneNumberController.text,
      "country": countryController.text,
      "card_number": cardNumberController.text,
      "card_type": cardTypeController.text,
      "card_expiry": cardExpiryController.text,
      "card_cvc": cardCVCController.text,
    };

    var _response = await http.post(
        Uri.parse(ApiRoutes.baseUrl + ApiRoutes.addCard),
        body: _body,
        headers: _header);

    _logger.d(_response.body);
    if (_response.statusCode == 200) {
      isCardAdded.value = true;
      var _status = addCardFieldsModelFromJson(_response.body);
      if (_status.code == "1") {
        //var _result = addCardFieldsSuccessModelFromJson(_response.body);
        _box.put(GlobalVals.addCard, _response.body);
        cardScreenIndex.value = 1;
      } else {
        Fluttertoast.showToast(
            msg: _status.message, backgroundColor: Colors.red);
      }
    } else {
      isCardAdded.value = true;
      Fluttertoast.showToast(
          msg: "Server error: ${_response.statusCode}",
          backgroundColor: Colors.red);
    }
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  void onInit() {
    addBank.add(_bankFields());
    addCard.add(_cardFields());
    /*videoPlayerController = VideoPlayerController.network(
        "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4");
    videoPlayerController.initialize();
    videoPlayerController.play();*/
    tabBar = TabBar(
      onTap: (index) {
        currentIndex.value = index;
      },
      tabs: [
        Tab(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.h),
            child: Column(
              children: [
                Icon(
                  Icons.account_balance,
                  color: GlobalVals.appbarColor,
                ),
                Text(
                  "Add Bank",
                  style: TextStyle(color: GlobalVals.appbarColor),
                ),
              ],
            ),
          ),
        ),
        Tab(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.h),
            child: Column(
              children: [
                Icon(
                  Icons.credit_card,
                  color: GlobalVals.appbarColor,
                ),
                Text(
                  "Add Card",
                  style: TextStyle(color: GlobalVals.appbarColor),
                ),
              ],
            ),
          ),
        ),
      ],
    );
    size = tabBar.preferredSize;
    super.onInit();
  }

  pickImage() async {
    /*final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      isFromAsset.value = false;
      avatar.value = photo.path;
    }*/
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
              final ImagePicker _picker = ImagePicker();
              final XFile? photo =
                  await _picker.pickImage(source: ImageSource.gallery);
              if (photo != null) {
                isFromAsset.value = false;
                avatar.value = photo.path;
                Get.back();
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
              final ImagePicker _picker = ImagePicker();
              final XFile? photo =
                  await _picker.pickImage(source: ImageSource.camera);
              if (photo != null) {
                isFromAsset.value = false;
                avatar.value = photo.path;
                Get.back();
              }
            },
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }

  pickImage4() async {
    /*final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      isFromAsset.value = false;
      avatar.value = photo.path;
    }*/
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
              final ImagePicker _picker = ImagePicker();
              final XFile? photo =
                  await _picker.pickImage(source: ImageSource.gallery);
              if (photo != null) {
                isFromAsset4.value = false;
                avatar4.value = photo.path;
                Get.back();
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
              final ImagePicker _picker = ImagePicker();
              final XFile? photo =
                  await _picker.pickImage(source: ImageSource.camera);
              if (photo != null) {
                isFromAsset4.value = false;
                avatar4.value = photo.path;
                Get.back();
              }
            },
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }

  pickImage2() async {
    /*final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      isFromAsset2.value = false;
      avatar2.value = photo.path;
    }*/
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
              final ImagePicker _picker = ImagePicker();
              final XFile? photo =
                  await _picker.pickImage(source: ImageSource.gallery);
              if (photo != null) {
                isFromAsset2.value = false;
                avatar2.value = photo.path;
                Get.back();
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
              final ImagePicker _picker = ImagePicker();
              final XFile? photo =
                  await _picker.pickImage(source: ImageSource.camera);
              if (photo != null) {
                isFromAsset2.value = false;
                avatar2.value = photo.path;
                Get.back();
              }
            },
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }

  pickVideo() async {
    /*final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      isFromAsset.value = false;
      avatar.value = photo.path;
    }*/
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
              final ImagePicker _picker = ImagePicker();
              final XFile? photo =
                  await _picker.pickVideo(source: ImageSource.gallery);
              if (photo != null) {
                isFromAsset3.value = false;
                video3.value = photo.path;
                videoPlayerController =
                    VideoPlayerController.file(File(video3.value));
                videoPlayerController.initialize();
                videoPlayerController.play();
                Get.back();
              }
            },
          ),
          ListTile(
            title: Text("Capture Video"),
            leading: Icon(
              Icons.videocam_rounded,
              color: Colors.blue,
            ),
            onTap: () async {
              final ImagePicker _picker = ImagePicker();
              final XFile? photo =
                  await _picker.pickVideo(source: ImageSource.camera);
              if (photo != null) {
                isFromAsset3.value = false;
                video3.value = photo.path;
                videoPlayerController = VideoPlayerController.file(
                  File(video3.value),
                );
                videoPlayerController.initialize();
                videoPlayerController.play();
                Get.back();
              }
            },
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }

  Column _bankFields() {
    return Column(
      children: [
        _textFields("Your full name as per bank record"),
        SizedBox(
          height: 2.h,
        ),
        _textFields("Full bank name"),
        SizedBox(
          height: 2.h,
        ),
        _textFields("Account Number"),
        SizedBox(
          height: 2.h,
        ),
        _textFields("Confirm Account Number"),
        SizedBox(
          height: 2.h,
        ),
        _textFields("IFSC Code"),
        SizedBox(
          height: 2.h,
        ),
        _textFields("MICR Code"),
        SizedBox(
          height: 2.h,
        ),
        _textFields("UPI/VPA"),
        SizedBox(
          height: 2.h,
        ),
        _textFields("Branch Name"),
        SizedBox(
          height: 2.h,
        ),
        Container(
          width: double.infinity,
          height: 17.h,
          child: TextField(
            maxLines: 2,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  3.h,
                ),
                gapPadding: 1.0,
              ),
              hintText: "Branch Address",
              focusColor: Colors.blue,
              contentPadding: EdgeInsets.symmetric(
                vertical: 5.h,
                horizontal: 5.h,
              ),
            ),
          ),
        ),
        _textFields("Branch City"),
        SizedBox(
          height: 2.h,
        ),
        _textFields("Branch Zip Code"),
        SizedBox(
          height: 2.h,
        ),
        _textFields("Branch Telephone"),
        SizedBox(
          height: 2.h,
        ),
        Container(
          width: double.infinity,
          child: ElevatedButton(
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
            onPressed: () {},
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              child: const Text("Continue"),
            ),
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
      ],
    );
  }

  Column _cardFields() {
    return Column(
      children: [
        _textFields("Name on Card"),
        SizedBox(
          height: 2.h,
        ),
        Container(
          width: double.infinity,
          height: 17.h,
          child: TextField(
            maxLines: 2,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  3.h,
                ),
                gapPadding: 1.0,
              ),
              hintText: "Billing Address",
              focusColor: Colors.blue,
              contentPadding: EdgeInsets.symmetric(
                vertical: 5.h,
                horizontal: 5.h,
              ),
            ),
          ),
        ),
        _textFields("City"),
        SizedBox(
          height: 2.h,
        ),
        _textFields("State"),
        SizedBox(
          height: 2.h,
        ),
        _textFields("Post/Zip Code"),
        SizedBox(
          height: 2.h,
        ),
        _textFields("Telephone Number"),
        SizedBox(
          height: 2.h,
        ),
        _textFields("Country"),
        SizedBox(
          height: 2.h,
        ),
        _textFields("Card Number"),
        SizedBox(
          height: 2.h,
        ),
        _textFields("Card Type"),
        SizedBox(
          height: 2.h,
        ),
        _textFields("Card Expiry"),
        SizedBox(
          height: 2.h,
        ),
        _textFields("CVV"),
        Padding(
          padding: EdgeInsets.only(bottom: 1.h, left: 1.h, right: 1.h),
          child: Container(
            width: double.infinity,
            child: ElevatedButton(
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
              onPressed: () {},
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                child: const Text("Continue"),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
      ],
    );
  }

  Container _textFields(String hint) {
    return Container(
      width: double.infinity,
      child: TextField(
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              5.h,
            ),
            gapPadding: 1.0,
          ),
          hintText: hint,
          focusColor: Colors.blue,
          contentPadding: EdgeInsets.symmetric(
            vertical: 1.h,
            horizontal: 2.h,
          ),
        ),
      ),
    );
  }

  addDocument() async {
    isUploaded.value = false;
    Future.delayed(Duration(seconds: 2), () {
      isVisible.value = true;
    });
    final _userInfo =
        UserModel.fromJson(json.decode(_box.get(GlobalVals.user)));
    final _cardInfo =
        addCardFieldsSuccessModelFromJson(_box.get(GlobalVals.addCard));
    final _token = _userInfo.result.token;
    var _request = new http.MultipartRequest(
        "POST", Uri.parse(ApiRoutes.baseUrl + ApiRoutes.cardDocument));
    Map<String, String> _header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    };
    var _frontFile = File(avatar.value);
    var _frontStream = new http.ByteStream(_frontFile.openRead()..cast());
    var _frontLength = await _frontFile.length();
    var _frontFileBody = new http.MultipartFile(
        'card', _frontStream, _frontLength,
        filename: basename(_frontFile.path));

    var _frontSelfieFile = File(avatar2.value);
    var _frontSelfieStream =
        new http.ByteStream(_frontSelfieFile.openRead()..cast());
    var _frontSelfieLength = await _frontSelfieFile.length();
    var _frontSelfieFileBody = new http.MultipartFile(
        'card_with_selfie', _frontSelfieStream, _frontSelfieLength,
        filename: basename(_frontSelfieFile.path));

    var _statementFile = File(avatar2.value);
    var _statementStream =
        new http.ByteStream(_statementFile.openRead()..cast());
    var _statementLength = await _statementFile.length();
    var _statementFileBody = new http.MultipartFile(
        'statement', _statementStream, _statementLength,
        filename: basename(_frontSelfieFile.path));

    var _videoFile = File(video3.value);
    var _videoStream = new http.ByteStream(_videoFile.openRead()..cast());
    var _videoLength = await _videoFile.length();
    var _videoFileBody = new http.MultipartFile(
      'cardVideo',
      _videoStream,
      _videoLength,
      filename: basename(_videoFile.path),
    );
    _request.headers.addAll(_header);
    _request.files.add(_frontFileBody);
    _request.files.add(_frontSelfieFileBody);
    _request.files.add(_statementFileBody);
    _request.files.add(_videoFileBody);
    _request.fields["card_id"] = _cardInfo.result.cardId.toString();
    var _response = await _request.send();
    _logger.d(_response.statusCode);
    _response.stream.transform(utf8.decoder).listen((event) async {
      //isUploaded.value = true;
      var _box = await Hive.openBox(GlobalVals.hiveBox);
      _box.put(GlobalVals.kycUploadModel, event);
      //Get.offNamed(Routes.verifyKycUpload);
      //GlobalVals.successToast("Information Added Successfully");
      //Get.offAllNamed(Routes.mainScreenCopy);
      //Get.offNamed(Routes.addAccountSuccessful);
      getProfileInfo();
      _logger.d(event);
    });
  }
  getProfileInfo() async {
    final _box = await Hive.openBox(GlobalVals.hiveBox);
    final _userInfo =
    UserModel.fromJson(json.decode(_box.get(GlobalVals.user)));
    final _token = _userInfo.result.token;
    _logger.d(_token);
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
      _box.put(GlobalVals.profileInfo, _response.body).then((value) {
        //Get.offAllNamed(Routes.mainScreenCopy)
        isUploaded.value = true;
        GlobalVals.successToast("Information Added Successfully");
        Get.offAllNamed(Routes.mainScreenCopy);
      });
      //Get.offAllNamed(Routes.mainScreenCopy);
      //responseResult.value = _response.body;
      // var _result = DashboardModel.fromJson(json.decode(_response.body));
      //resultLength.value = _result.cryptoData.length;
      /*
      _logger.d(_token); */
    } else {
      //Get.offAllNamed(Routes.mainScreen);
      GlobalVals.errorToast("Server Error");
    }
  }
}
