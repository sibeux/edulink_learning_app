// ignore_for_file: sized_box_for_whitespace

import 'package:cached_network_image/cached_network_image.dart';
import 'package:edulink_learning_app/components/string_formatter.dart';
import 'package:edulink_learning_app/components/toast.dart';
import 'package:edulink_learning_app/models/explore_mentor.dart';
import 'package:edulink_learning_app/widgets/mentor/button_book.dart';
import 'package:edulink_learning_app/widgets/mentor/rating_container_explore_mentor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class ListileExploreMentor extends StatelessWidget {
  const ListileExploreMentor({super.key, required this.mentor});

  final ExploreMentor mentor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            spreadRadius: -2,
            blurRadius: 16,
            offset: Offset(2, 5), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(16.0.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.r),
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(color: HexColor('#ffdb99')),
                    child: CachedNetworkImage(
                      imageUrl: mentor.uriPhoto ?? '',
                      fit: BoxFit.cover,
                      height: 70,
                      width: 70,
                      maxHeightDiskCache: 300,
                      maxWidthDiskCache: 300,
                      filterQuality: FilterQuality.medium,
                      placeholder:
                          (context, url) => Center(
                            child: SizedBox(
                              height: 70.h,
                              width: 70.w,
                              child: Image.asset(
                                'assets/images/screens/Edit Profile.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                      errorWidget:
                          (context, url, error) => Center(
                            child: SizedBox(
                              height: 70.h,
                              width: 70.w,
                              child: Image.asset(
                                'assets/images/screens/Edit Profile.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mentor.name.capitalize!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Text(
                        mentor.name.contains('b') ? 'Math • ' : 'Science • ',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: HexColor('#BABABA').withValues(alpha: 0.93),
                        ),
                      ),
                      RatingContainerExploreMentor(mentor: mentor),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      color: HexColor('#E5ECFF'),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Text(
                      '50+ students have been mentored',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        color: HexColor('#1A1A1A'),
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  // Handle favorite action
                  showToast('This feature is not available yet');
                },
                child: Icon(
                  Icons.favorite_border,
                  size: 20.sp,
                  color: HexColor('#1A1A1A'),
                ),
              ),
              Spacer(),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 4.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cost/Hour',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: HexColor('#545454').withValues(alpha: 0.93),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      formatPrice(
                        (mentor.price is double)
                            ? mentor.price as double
                            : double.tryParse(
                                  mentor.price?.toString() ?? '0',
                                ) ??
                                0.0,
                      ),
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: HexColor('#054BFF'),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                mentor.schedule!.contains('true')
                    ? Expanded(child: ButtonBookEnable())
                    : Expanded(
                      child: AbsorbPointer(child: ButtonBookDisable()),
                    ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}
