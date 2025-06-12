import 'package:edulink_learning_app/controllers/profile_teacher_controller.dart';
import 'package:edulink_learning_app/models/teacher_availabilty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ListileAvailableDate extends StatelessWidget {
  const ListileAvailableDate({super.key, required this.teacherAvailabilty});

  final TeacherAvailabilty teacherAvailabilty;

  @override
  Widget build(BuildContext context) {
    final ProfileTeacherController profileTeacherController =
        Get.find<ProfileTeacherController>();
    final String startHour =
        teacherAvailabilty.startTime?.split(':')[0] ?? '00';
    final String startMinute =
        teacherAvailabilty.startTime?.split(':')[1] ?? '00';
    final String endHour = teacherAvailabilty.endTime?.split(':')[0] ?? '00';
    final String endMinute = teacherAvailabilty.endTime?.split(':')[1] ?? '00';
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Material(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.circular(10.r),
        clipBehavior:
            Clip.antiAlias, // ✅ ini penting biar splash-nya ikut radius.
        child: InkWell(
          onTap: () {
            // changeTimeModal(context, waterTime: waterTime);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Obx(
                          () =>
                              profileTeacherController
                                          .updateRefreshSetAvailableDay
                                          .value ||
                                      !profileTeacherController
                                          .updateRefreshSetAvailableDay
                                          .value
                                  ? Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: teacherAvailabilty.availableDay,
                                          style: TextStyle(
                                            fontSize: 24.sp,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                teacherAvailabilty
                                                        .isAvailable
                                                        .value
                                                    ? Colors.black
                                                    : Colors.grey.withAlpha(
                                                      150,
                                                    ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                  : SizedBox(),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    Obx(
                      () => Text(
                        !teacherAvailabilty.isAvailable.value
                            ? 'Off'
                            : '$startHour:$startMinute - $endHour:$endMinute',
                        style: TextStyle(
                          color:
                              teacherAvailabilty.isAvailable.value
                                  ? Colors.black.withAlpha(160)
                                  : Colors.grey.withAlpha(150),
                        ),
                      ),
                    ),
                  ],
                ),
                Obx(
                  () => Switch(
                    value: teacherAvailabilty.isAvailable.value,
                    onChanged: (value) {
                      // Kalau ada return di atas, maka tidak akan lanjut ke bawah.
                      teacherAvailabilty.isAvailable.value = value;
                      profileTeacherController.toggleSetAvailableDay(
                        teacherAvailabilty.id.toString(),
                        value,
                      );
                    },
                    activeColor: Color.fromARGB(255, 69, 214, 149),
                    inactiveTrackColor: Color(0xffD9D9D9),
                    inactiveThumbColor: Color(0xffFFFFFF),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
