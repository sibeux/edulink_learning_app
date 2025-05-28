import 'dart:convert';
import 'dart:math';

import 'package:edulink_learning_app/components/colorize_terminal.dart';
import 'package:edulink_learning_app/controllers/user_profile_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:http_parser/http_parser.dart';

class CompleteProfileController extends GetxController {
  final box = GetStorage();

  var email = ''.obs;
  var photoUri = ''.obs;
  var oldPhotoUri = '';

  var profileStudentCompleted = false.obs;
  var courseStudentCompleted = false.obs;
  var isInsertImageLoading = false.obs;
  var isSendingDataLoading = false.obs;
  var isImageFileTooLarge = false.obs;
  var isImageChanged = false.obs;

  @override
  void onInit() {
    email.value = box.read('email') ?? '';
    super.onInit();
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
            'email': email.value,
            'name': userProfileController.userData[0].nameUser,
            'photo':
                isImageChanged.value &&
                        !photoUri.value.contains('http') &&
                        !photoUri.value.contains('://')
                    ? 'https://edulink.blob.core.windows.net/images/$fileNameImageProfile'
                    : photoUri.value,
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
