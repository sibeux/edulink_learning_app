import 'dart:convert';

import 'package:edulink_learning_app/components/colorize_terminal.dart';
import 'package:edulink_learning_app/controllers/user_profile_controller.dart';
import 'package:edulink_learning_app/widgets/complete_profile/form/education_pick.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:http_parser/http_parser.dart';

List<String> genderList = ['male', 'female', 'other'];

class CompleteProfileController extends GetxController {
  final box = GetStorage();

  var email = ''.obs;
  var photoUri = ''.obs;
  var oldPhotoUri = '';
  var currentType = ''.obs;

  var profileStudentCompleted = false.obs;
  var courseStudentCompleted = false.obs;
  var isInsertImageLoading = false.obs;
  var isSendingDataLoading = false.obs;
  var isImageFileTooLarge = false.obs;
  var isImageChanged = false.obs;

  late FixedExtentScrollController dayController;
  late FixedExtentScrollController monthController;
  late FixedExtentScrollController yearController;

  var selectedDay = 0.obs;
  var selectedMonth = 0.obs;
  var selectedYear = 0.obs;
  var selectedGender = ''.obs;
  var selectedEducationLevel = ''.obs;
  var selectedEducationType = ''.obs;

  final List<int> years = List.generate(70, (i) => 1960 + i);
  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  var formData = RxMap({
    'nameProfile': {
      'text': '',
      'type': 'nameProfile',
      'controller': TextEditingController(),
    },
    'emailProfile': {
      'text': '',
      'type': 'emailProfile',
      'controller': TextEditingController(),
    },
    'numberProfile': {
      'text': '',
      'type': 'numberProfile',
      'controller': TextEditingController(),
    },
    'birthdayProfile': {
      'text': '',
      'type': 'birthdayProfile',
      'controller': TextEditingController(),
    },
    'cityProfile': {
      'text': '',
      'type': 'cityProfile',
      'controller': TextEditingController(),
    },
    'countryProfile': {
      'text': '',
      'type': 'countryProfile',
      'controller': TextEditingController(),
    },
    'addressProfile': {
      'text': '',
      'type': 'addressProfile',
      'controller': TextEditingController(),
    },
    'coursesProfile': {
      'text': '',
      'type': 'coursesProfile',
      'controller': TextEditingController(),
    },
  });

  @override
  void onInit() {
    email.value = box.read('email') ?? '';
    super.onInit();
  }

  void setUpBirthDatePickerController() {
    final TextEditingController birthdayController =
        formData['birthdayProfile']?['controller'] as TextEditingController;

    final int day = int.parse(birthdayController.text.split('/')[0]);
    final int month = int.parse(birthdayController.text.split('/')[1]);
    final int year = int.parse(birthdayController.text.split('/')[2]);

    dayController = FixedExtentScrollController(initialItem: day - 1);
    monthController = FixedExtentScrollController(initialItem: month - 1);
    yearController = FixedExtentScrollController(
      initialItem: years.indexOf(year),
    );

    selectedDay.value = day;
    selectedMonth.value = month;
    selectedYear.value = year;

    logInfo('Birth date picker controllers initialized: $day, $month, $year');
  }

  void assignCurrentDataForm() {
    final userProfileController = Get.find<UserProfileController>();
    photoUri.value = userProfileController.userData[0].userPhoto;
    final userData = userProfileController.userData[0];

    final TextEditingController nameController =
        formData['nameProfile']?['controller'] as TextEditingController;
    final TextEditingController emailController =
        formData['emailProfile']?['controller'] as TextEditingController;
    final TextEditingController numberController =
        formData['numberProfile']?['controller'] as TextEditingController;
    final TextEditingController birthdayController =
        formData['birthdayProfile']?['controller'] as TextEditingController;
    final TextEditingController cityController =
        formData['cityProfile']?['controller'] as TextEditingController;
    final TextEditingController countryController =
        formData['countryProfile']?['controller'] as TextEditingController;
    final TextEditingController addressController =
        formData['addressProfile']?['controller'] as TextEditingController;

    formData['nameProfile'] = {
      'text': userData.nameUser,
      'type': 'nameProfile',
      'controller': nameController,
    };
    formData['emailProfile'] = {
      'text': userData.emailuser,
      'type': 'emailProfile',
      'controller': emailController,
    };
    formData['numberProfile'] = {
      'text': userData.userPhone,
      'type': 'numberProfile',
      'controller': numberController,
    };
    formData['birthdayProfile'] = {
      'text': userData.userBirthday,
      'type': 'birthdayProfile',
      'controller': birthdayController,
    };
    formData['cityProfile'] = {
      'text': userData.userCity,
      'type': 'cityProfile',
      'controller': cityController,
    };
    formData['countryProfile'] = {
      'text': userData.userCountry,
      'type': 'countryProfile',
      'controller': countryController,
    };
    formData['addressProfile'] = {
      'text': userData.userAddress,
      'type': 'addressProfile',
      'controller': addressController,
    };

    nameController.text = userData.nameUser;
    emailController.text = userData.emailuser;
    numberController.text = userData.userPhone;
    birthdayController.text = userData.userBirthday;
    cityController.text = userData.userCity;
    countryController.text = userData.userCountry;
    addressController.text = userData.userAddress;
    selectedGender.value = userData.userGender;
    selectedEducationLevel.value =
        userData.userEducation == ''
            ? ''
            : educationTypes.entries
                .firstWhere(
                  (entry) => entry.value.contains(userData.userEducation),
                  orElse: () => const MapEntry('', []),
                )
                .key;
    selectedEducationType.value = userData.userEducation;
    isImageChanged.value = false;
    currentType.value = '';
    update();
  }

  void onChanged(String value, String type) {
    final currentController = formData[type]?['controller'];
    // Memperbarui referensi map
    formData[type] = {
      'text': value.trim(),
      'type': type,
      'controller': currentController!,
    };
    update();
  }

  void onTap(String type, bool isFocus) {
    final currentController = formData[type]?['controller'];
    final currentText = formData[type]?['text'];
    formData[type] = {
      'text': currentText!,
      'type': type,
      'controller': currentController!,
    };
    currentType.value = isFocus ? type : '';
    update();
  }

  Future<void> insertImage() async {
    oldPhotoUri = Get.find<UserProfileController>().userData[0].userPhoto;
    final ImagePicker picker = ImagePicker();

    isInsertImageLoading.value = true;

    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      final size = await pickedFile.length();
      if (size > 2000000) {
        isImageFileTooLarge.value = true;
      } else {
        isImageFileTooLarge.value = false;

        photoUri.value = pickedFile.path;
        isImageChanged.value = true;
      }
    }
    isInsertImageLoading.value = false;
  }

  bool getIsNameValid() {
    final nameValue = formData['nameProfile']!['text'].toString();
    final nameRegExp = RegExp(r'^[a-zA-Z\s]+$');

    return !nameRegExp.hasMatch(nameValue) && nameValue.isNotEmpty;
  }

  bool getIsAllDataValid() {
    return !getIsNameValid() &&
        selectedGender.value.isNotEmpty &&
        selectedEducationType.value.isNotEmpty &&
        formData['nameProfile']!['text']!.toString().isNotEmpty &&
        formData['cityProfile']!['text']!.toString().isNotEmpty;
  }

  String generateImageName(String idUser) {
    const uuid = Uuid();

    return "profile_${uuid.v4()}.jpg";
  }

  Future<void> sendChangeProfileData() async {
    isSendingDataLoading.value = true;

    const String url = "https://sibeux.my.id/project/edulink-php-jwt/api/user";
    const String imageUploadUrl =
        'https://sibeux.my.id/project/edulink-php-jwt/api/files/images/upload';

    var fileNameImageProfile = '';

    try {
      final requestUploadImage = http.MultipartRequest(
        'POST',
        Uri.parse(imageUploadUrl),
      );

      final userProfileController = Get.find<UserProfileController>();

      if (photoUri.isNotEmpty &&
          (!photoUri.value.contains('http') &&
              !photoUri.value.contains('://'))) {
        fileNameImageProfile = generateImageName(
          userProfileController.userData[0].userId,
        );
        requestUploadImage.files.add(
          await http.MultipartFile.fromPath(
            'file',
            photoUri.value,
            filename: fileNameImageProfile,
            contentType: MediaType('image', 'jpeg'),
          ),
        );
      }

      var responseUploadImage = http.StreamedResponse(
        const Stream.empty(),
        500,
      );

      if (isImageChanged.value) {
        responseUploadImage = await requestUploadImage.send();
      }

      if (responseUploadImage.statusCode == 200 || !isImageChanged.value) {
        if (isImageChanged.value) {
          logSuccess('Image uploaded');
        }

        final response = await http.post(
          Uri.parse(url),
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
          body: {
            'method': 'change_user_data',
            'name': formData['nameProfile']?['text'] ?? '',
            'email': email.value,
            'photo':
                isImageChanged.value &&
                        !photoUri.value.contains('http') &&
                        !photoUri.value.contains('://')
                    ? 'https://edulink.blob.core.windows.net/images/$fileNameImageProfile'
                    : photoUri.value,
            'birthday': formData['birthdayProfile']?['text'] ?? '',
            'gender': selectedGender.value,
            'city': formData['cityProfile']?['text'] ?? '',
            'country': formData['countryProfile']?['text'] ?? '',
            'address': formData['addressProfile']?['text'] ?? '',
            'education': selectedEducationType.value,
          },
        );

        if (response.body.isEmpty) {
          logError('Response body is empty');
          return;
        }

        final responseBody = jsonDecode(response.body);

        if (response.statusCode == 200 && responseBody['status'] == 'success') {
          logSuccess('Data berhasil dikirim: ${response.body}');

          await userProfileController.getUserData();

          if (photoUri.value != oldPhotoUri && oldPhotoUri.isNotEmpty) {
            deleteImageFromAzure();
          }

          profileStudentCompleted.value = true;
          Get.back();
        } else {
          logError('Error send data: ${response.body}');
        }
      } else {
        logError('Error upload image: ${responseUploadImage.reasonPhrase}');
      }
    } catch (e) {
      logError('Error try catch from sendChangeProfileData: $e');
    } finally {
      isSendingDataLoading.value = false;
    }
  }

  Future<void> deleteImageFromAzure() async {
    const String imageDeleteUrl =
        'https://sibeux.my.id/project/edulink-php-jwt/api/files/images/delete';

    var fileNameImageProfile = '';

    try {
      if (oldPhotoUri != photoUri.value && oldPhotoUri.isNotEmpty) {
        fileNameImageProfile = oldPhotoUri.split('/').last;
      }

      final response = await http.post(
        Uri.parse(imageDeleteUrl),
        body: jsonEncode({
          'filename': [fileNameImageProfile],
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.body.isEmpty) {
        logError('Response body is empty');
        return;
      }
      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['status'] == 'done') {
        logSuccess('Image berhasil dihapus.');
      } else {
        logError('Image gagal dihapus.');
      }
    } catch (error) {
      logError('Error deleteImageFromAzure: $error');
    } finally {}
  }
}
