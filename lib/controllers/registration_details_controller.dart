import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:masscoinex/global/global_vals.dart';
import 'package:masscoinex/models/register_user/register_user_model.dart';
import 'package:masscoinex/routes/route_list.dart';
import 'package:path/path.dart';
import 'package:masscoinex/api/api_routes.dart';
import 'package:masscoinex/views/screens/auth/registration/registration_details_screen/declaration_screen.dart';
import 'package:masscoinex/views/screens/auth/registration/registration_details_screen/document_screen.dart';
import 'package:masscoinex/views/screens/auth/registration/registration_details_screen/selfie_id_screen.dart';
import 'package:masscoinex/views/screens/auth/registration/registration_details_screen/selfie_screen.dart';

class RegistrationDetailsController extends GetxController {
  var currentIndex = 0.obs;
  var previousIndex = 0.obs;
  var uploadImageFront = XFile("").obs;
  var uploadImageBack = XFile("").obs;
  var uploadSelfieID = XFile("").obs;
  var uploadSelfie = XFile("").obs;
  var uploadDeclaration = XFile("").obs;
  var uploadDocType = "".obs;
  var isFrontAndBackSelected = false.obs;
  var isSelfieWithIdSelected = false.obs;
  var isSelfieSelected = false.obs;
  var isDeclarationSelected = false.obs;
  var isUploaded = false.obs;
  final _logger = Logger();

  List<StatelessWidget> screens(
      RegistrationDetailsController registrationDetailsController) {
    return [
      DocumentScreen(
        registrationDetailsController: registrationDetailsController,
      ),
      SelfieIdScreen(
        registrationDetailsController: registrationDetailsController,
      ),
      SelfieScreen(
        registrationDetailsController: registrationDetailsController,
      ),
      DeclarationScreen(
        registrationDetailsController: registrationDetailsController,
      ),
    ];
  }

  uploadImagesToKyc() async {
    isUploaded.value = true;
    var _box = await Hive.openBox(GlobalVals.hiveBox);
    var _result = RegisterModel.fromJsonSuccess(
        json.decode(_box.get(GlobalVals.register)));
    /* String _testToken =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6Ijk0YmZlNWViYzhjYjhhYjZiYzRkMWZjM2FjYjFkM2ExMmZlZmY4ZDNmYWUzNDNkY2RmNDhkNGIxMmNiMzMzZTRlOThiZTcxNzQ3MmYxMGRjIn0.eyJhdWQiOiIxIiwianRpIjoiOTRiZmU1ZWJjOGNiOGFiNmJjNGQxZmMzYWNiMWQzYTEyZmVmZjhkM2ZhZTM0M2RjZGY0OGQ0YjEyY2IzMzNlNGU5OGJlNzE3NDcyZjEwZGMiLCJpYXQiOjE2MzU4MjA2MTIsIm5iZiI6MTYzNTgyMDYxMiwiZXhwIjoxNjY3MzU2NjEyLCJzdWIiOiIxODA0Iiwic2NvcGVzIjpbXX0.Mxyg-d1YWlyujd1hKJ1ncQXPlWO_6IXFi7CW7sk-NnMaZRLGEg1yyS51gE9p6rjbg9SK02wWW0NyKEi21tTFGKffOvaChtStYjQYCg5B-b6IL3xEem5OnISmreFlxkeOVIk0IYutV-K_kKaq7RntbbqxYfMTfJ3qIaLW4oiSBaaDpG_8ndBGJyy3l5zmNjCtQmPDiDtF1T8lTlwF-KNvt0_MXmbeqA5_tvVF2DW5hKhwTacngWarNCWL9BzSfukqxD8C2c9p0f8s2Qt4IZLAYDyxYdPDfoIm7oFkiH2sYBcoSEK1ZLgX1MHKe_YbbmuEU5MGfBal4OQxqmX1gCTXYqImoiZgEemzQCohn6DtGC5WFLyKTIXn74MGpou2pyuyDmIse35zAVOsy5B9rvTUf3JfVQLHSQNfH8M6GNsc_hAH7r5W-q9bkweHxuoa0ptydxoCSTsFhP325D8lwA390kizQCDcczH1kXg-Ifoa3OPCDopwL_Idai-evAEVp2ZD7tmXMEFVvOq3GuJRi3P-G45tWtr6TWDFPBfHYM7muzDYT-k9_MOHm4LSJE5Lf9dZ2nidQ8z06nWIE3He2G3sdq16dO5s5C6GBRJfgLvpd-mPHVfCkutY8PO54UE1ytUtbUdailiN_tc5mzGpGdNqzfKNhFxXFyDKZSlNiNvdE-s"; */
    var _request = new http.MultipartRequest(
        "POST", Uri.parse(ApiRoutes.baseUrl + ApiRoutes.kycUpgrade));
    Map<String, String> _header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${_result.registerResult!.token}',
    };
    /* Front */
    var _frontStream =
        new http.ByteStream(uploadImageFront.value.openRead()..cast());
    var _frontLength = await uploadImageFront.value.length();
    var _frontFile = new http.MultipartFile(
        'idproof', _frontStream, _frontLength,
        filename: basename(uploadImageFront.value.path));
    /* Back */
    var _backStream =
        new http.ByteStream(uploadImageBack.value.openRead()..cast());
    var _backLength = await uploadImageBack.value.length();
    var _backFile = new http.MultipartFile('idback', _backStream, _backLength,
        filename: basename(uploadImageBack.value.path));
    /* Selfie with id */
    var _selfieIdStream =
        new http.ByteStream(uploadSelfieID.value.openRead()..cast());
    var _selfieIdLength = await uploadSelfieID.value.length();
    var _selfieIdFile = new http.MultipartFile(
        'selfie_with_id', _selfieIdStream, _selfieIdLength,
        filename: basename(uploadSelfieID.value.path));
    /* Selfie */
    var _selfieStream =
        new http.ByteStream(uploadSelfie.value.openRead()..cast());
    var _selfieLength = await uploadSelfie.value.length();
    var _selfieFile = new http.MultipartFile(
        'selfie', _selfieStream, _selfieLength,
        filename: basename(uploadSelfie.value.path));
    /* Declaration */
    var _declarationStream =
        new http.ByteStream(uploadDeclaration.value.openRead()..cast());
    var _declarationLength = await uploadDeclaration.value.length();
    var _declarationFile = new http.MultipartFile(
        'written', _declarationStream, _declarationLength,
        filename: basename(uploadDeclaration.value.path));
    _request.files.add(_frontFile);
    _request.files.add(_backFile);
    _request.files.add(_selfieIdFile);
    _request.files.add(_selfieFile);
    _request.files.add(_declarationFile);
    _request.headers.addAll(_header);
    _request.fields["document_type"] = uploadDocType.value;
    var _response = await _request.send();
    _logger.d(_response.statusCode);
    _response.stream.transform(utf8.decoder).listen((event) async {
      isUploaded.value = false;
      Get.toNamed(Routes.kycUploadedScreen);
      var _box = await Hive.openBox(GlobalVals.hiveBox);
      _box.put(GlobalVals.kycUploadModel, event);
      _logger.d(event);
    });
  }
}
