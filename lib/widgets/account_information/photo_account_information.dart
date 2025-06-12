import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:edulink_learning_app/controllers/complete_profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class PhotoAccountInformation extends StatelessWidget {
  const PhotoAccountInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final completeProfileController = Get.find<CompleteProfileController>();
    return ClipRRect(
      borderRadius: BorderRadius.circular(100.r),
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(color: HexColor('#ffdb99')),
        child: Obx(
          () =>
              completeProfileController.isInsertImageLoading.value
                  ? CupertinoActivityIndicator()
                  : (completeProfileController.photoUri.value.contains(
                            'http',
                          ) &&
                          completeProfileController.photoUri.value.contains(
                            '://',
                          )) ||
                      completeProfileController.photoUri.value.isEmpty
                  ? CachedNetworkImage(
                    imageUrl: completeProfileController.photoUri.value,
                    fit: BoxFit.cover,
                    height: 100,
                    width: 100,
                    maxHeightDiskCache: 300,
                    maxWidthDiskCache: 300,
                    filterQuality: FilterQuality.medium,
                    placeholder:
                        (context, url) => Center(
                          child: SizedBox(
                            height: 95.h,
                            width: 95.w,
                            child: Image.asset(
                              'assets/images/screens/Edit Profile.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                    errorWidget:
                        (context, url, error) => Center(
                          child: SizedBox(
                            height: 95.h,
                            width: 95.w,
                            child: Image.asset(
                              'assets/images/screens/Edit Profile.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                  )
                  : Image.file(
                    File(completeProfileController.photoUri.value),
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.medium,
                  ),
        ),
      ),
    );
  }
}
