import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/controllers/profile_teacher_controller.dart';
import 'package:edulink_learning_app/models/teacher_availabilty.dart';
import 'package:edulink_learning_app/widgets/profile_teacher/listile_available_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class SetAvailabiltyScreen extends StatelessWidget {
  const SetAvailabiltyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff7f7f7),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios_new, color: ColorPalette().primary),
        ),
        centerTitle: true,
        title: Text(
          'Available',
          style: TextStyle(
            color: HexColor('#1A1A1A'),
            fontSize: 28.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Save',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            title(
              context: context,
              title: 'Available Days',
              onTap: () {
                Get.snackbar(
                  'Add Availability',
                  'This feature is not implemented yet.',
                );
              },
            ),
            ListView.builder(
              shrinkWrap: true, // PENTING
              // Mencegah ListView memiliki scroll-nya sendiri,
              // karena scroll utama sudah ditangani oleh SingleChildScrollView.
              physics: const NeverScrollableScrollPhysics(), // PENTING
              itemBuilder: (context, index) {
                final map =
                    Get.find<ProfileTeacherController>()
                        .availabilityData[index];
                final teacherAvailability = TeacherAvailabilty.fromMap(map);
                return Container(
                  margin: EdgeInsets.only(bottom: 15.h),
                  child: ListileAvailableDate(
                    teacherAvailabilty: teacherAvailability,
                  ),
                );
              },
              itemCount:
                  Get.find<ProfileTeacherController>().availabilityData.length,
            ),
          ],
        ),
      ),
    );
  }
}

Widget title({
  required BuildContext context,
  required String title,
  required VoidCallback onTap,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: HexColor('#1A1A1A'),
          ),
        ),
      ],
    ),
  );
}

// class DibuangSayang extends StatelessWidget {
//   const DibuangSayang({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           title(
//             context: context,
//             title: 'Available Hours',
//             onTap: () {
//               Get.snackbar(
//                 'Add Availability',
//                 'This feature is not implemented yet.',
//               );
//             },
//           ),
//           ListView.builder(
//             shrinkWrap: true, // PENTING
//             // Mencegah ListView memiliki scroll-nya sendiri,
//             // karena scroll utama sudah ditangani oleh SingleChildScrollView.
//             physics: const NeverScrollableScrollPhysics(), // PENTING
//             itemBuilder: (context, index) {
//               return ListileAvailableDate();
//             },
//             itemCount: 4,
//           ),
//           SizedBox(height: 45.h),
//           title(
//             context: context,
//             title: 'Available Days',
//             onTap: () {
//               Get.snackbar(
//                 'Add Availability',
//                 'This feature is not implemented yet.',
//               );
//             },
//           ),
//           ListView.builder(
//             shrinkWrap: true, // PENTING
//             // Mencegah ListView memiliki scroll-nya sendiri,
//             // karena scroll utama sudah ditangani oleh SingleChildScrollView.
//             physics: const NeverScrollableScrollPhysics(), // PENTING
//             itemBuilder: (context, index) {
//               return ListileAvailableDate();
//             },
//             itemCount: 4,
//           ),
//         ],
//       ),
//     );
//   }
// }
