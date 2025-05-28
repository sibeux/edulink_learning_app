import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:edulink_learning_app/controllers/complete_profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class UserPhoto extends StatelessWidget {
  const UserPhoto({super.key});

  @override
  Widget build(BuildContext context) {
    final completeProfileController = Get.find<CompleteProfileController>();
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: HexColor('#a0a2a0').withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child:
            completeProfileController.isInsertImageLoading.value
                ? const SizedBox(
                  height: 90,
                  width: 90,
                  child: CupertinoActivityIndicator(),
                )
                : (completeProfileController.photoUri.value.contains('http') &&
                        completeProfileController.photoUri.value.contains(
                          '://',
                        )) ||
                    completeProfileController.photoUri.value.isEmpty
                ? ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CachedNetworkImage(
                    imageUrl: completeProfileController.photoUri.value,
                    fit: BoxFit.cover,
                    height: 90.h,
                    width: 90.w,
                    maxHeightDiskCache: 300,
                    maxWidthDiskCache: 300,
                    filterQuality: FilterQuality.medium,
                    placeholder:
                        (context, url) => Image.asset(
                          'assets/images/screens/document.png',
                          fit: BoxFit.cover,
                        ),
                    errorWidget:
                        (context, url, error) => Image.asset(
                          'assets/images/screens/document.png',
                          fit: BoxFit.cover,
                        ),
                  ),
                )
                : ClipRRect(
                  borderRadius: BorderRadius.circular(50.r),
                  child: Image.file(
                    File(completeProfileController.photoUri.value),
                    height: 90,
                    width: 90,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.medium,
                  ),
                ),
      ),
    );
  }
}
