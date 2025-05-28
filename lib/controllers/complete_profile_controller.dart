import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CompleteProfileController extends GetxController {
  final box = GetStorage();

  var email = '';
  var profileStudentCompleted = false.obs;
  var courseStudentCompleted = false.obs;

  @override
  void onInit() {
    email = box.read('email') ?? '';
    super.onInit();
  }
}
