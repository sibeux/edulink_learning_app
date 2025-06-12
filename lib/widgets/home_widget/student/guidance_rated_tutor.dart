import 'package:edulink_learning_app/components/toast.dart';
import 'package:edulink_learning_app/widgets/home_widget/student/container_guidance_tutor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

List<String> _dummyTutorNames = [
  'Arya Stark',
  'Adinda Putri',
  'Felicia Wijaya',
  'Steven Lim',
];
List<String> _dummyCourses = [
  'Mathematics',
  'Physics, Chemistry',
  'Computer Science',
  'Biology, English',
];
List<String> _dummyProfilePictures = [
  "assets/images/screens/dummy/tutor-home/1.jpg",
  "assets/images/screens/dummy/tutor-home/2.jpg",
  "assets/images/screens/dummy/tutor-home/3.jpg",
  "assets/images/screens/dummy/tutor-home/4.jpg",
];

class GuidanceRatedTutor extends StatelessWidget {
  const GuidanceRatedTutor({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Get guidance from top-\nrated tutors',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            InkWell(
              onTap: () {
                // Handle "See All" action
                showToast('This feature is not available yet');
              },
              child: Text(
                'See All',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: HexColor('#BABABA').withValues(alpha: 0.93),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 15.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 10.w),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            // Agar shadow tidak terpotong
            clipBehavior: Clip.none,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < 4; i++)
                  ContainerGuidanceTutor(
                    index: i,
                    image: _dummyProfilePictures[i],
                    name: _dummyTutorNames[i],
                    courses: _dummyCourses[i],
                    rating: '${4.5 + (i * 0.1)}',
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
