import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/controllers/complete_profile_controller.dart';
import 'package:edulink_learning_app/screens/auth/register_auth/complete_profile/courses_insert_screen.dart';
import 'package:edulink_learning_app/screens/auth/register_auth/complete_profile/profile_insert_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

const List<String> titleStudent = ['Profile', 'Courses'];
const List<String> titleTutor = ['Profile', 'Dcoument'];

const List<String> descStudent = [
  'Complete your profile to enhance your\napp experience',
  'Choose your course and learn with\nyour preferred tutor',
];
const List<String> descTutor = [
  'Complete your personal details to\nproceed to verification.',
  'Provide the required documents for\nthe verification process as a tutor.',
];

const List<String> imageStudent = [
  'assets/images/screens/Edit Profile.png',
  'assets/images/screens/courses.png',
];
const List<String> imageTutor = [
  'assets/images/screens/Edit Profile.png',
  'assets/images/screens/document.png',
];

class ContainerCompleteProfile extends StatelessWidget {
  const ContainerCompleteProfile({
    super.key,
    required this.index,
    required this.actor,
  });

  final int index;
  final String actor;

  @override
  Widget build(BuildContext context) {
    final completeProfileController = Get.find<CompleteProfileController>();
    return Obx(
      () =>
          (completeProfileController.profileStudentCompleted.value ||
                  !completeProfileController.profileStudentCompleted.value ||
                  completeProfileController.courseStudentCompleted.value ||
                  !completeProfileController.courseStudentCompleted.value)
              ? GestureDetector(
                onTap: () {
                  (actor == 'student' &&
                          index == 1 &&
                          !completeProfileController
                              .profileStudentCompleted
                              .value)
                      ? null
                      : index == 0
                      ? Get.to(
                        () => ProfileInsertScreen(actor: actor),
                        transition: Transition.rightToLeft,
                        fullscreenDialog: true,
                        popGesture: false,
                      )
                      : actor == 'student'
                      ? Get.to(
                        () => CoursesInsertScreen(actor: actor),
                        transition: Transition.rightToLeft,
                        fullscreenDialog: true,
                        popGesture: false,
                      )
                      : null;
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 18.h,
                  ),
                  decoration: BoxDecoration(
                    color:
                        (actor == 'student' &&
                                index == 1 &&
                                !completeProfileController
                                    .profileStudentCompleted
                                    .value)
                            ? HexColor('#EEEEEE')
                            : Colors.white,
                    borderRadius: BorderRadius.circular(17.r),
                    boxShadow: [
                      BoxShadow(
                        color:
                            (actor == 'student' &&
                                    index == 1 &&
                                    !completeProfileController
                                        .profileStudentCompleted
                                        .value)
                                ? HexColor('#ffffff')
                                : Colors.black.withValues(alpha: 0.12),
                        blurRadius: 16.r,
                        spreadRadius: -2.r,
                        offset: Offset(2, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 50.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: HexColor('#FFF3DC'),
                          shape: BoxShape.circle,
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            height: 36.h,
                            width: 36.w,
                            child: Image.asset(
                              actor == 'student'
                                  ? imageStudent[index]
                                  : imageTutor[index],
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            actor == 'student'
                                ? titleStudent[index]
                                : titleTutor[index],
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color:
                                  (actor == 'student' &&
                                          index == 1 &&
                                          !completeProfileController
                                              .profileStudentCompleted
                                              .value)
                                      ? HexColor('#BABABA')
                                      : Colors.black,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            actor == 'student'
                                ? descStudent[index]
                                : descTutor[index],
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color:
                                  (actor == 'student' &&
                                          index == 1 &&
                                          !completeProfileController
                                              .profileStudentCompleted
                                              .value)
                                      ? HexColor('#BABABA')
                                      : Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 30.sp,
                        color:
                            (actor == 'student' &&
                                        (index == 1 || index == 0) &&
                                        !completeProfileController
                                            .profileStudentCompleted
                                            .value) ||
                                    (actor == 'student' &&
                                        index == 1 &&
                                        !completeProfileController
                                            .courseStudentCompleted
                                            .value)
                                ? HexColor('#BABABA')
                                : ColorPalette().primary,
                      ),
                    ],
                  ),
                ),
              )
              : SizedBox(),
    );
  }
}
