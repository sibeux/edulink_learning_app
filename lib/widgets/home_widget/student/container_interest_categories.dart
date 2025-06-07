import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

List<String> _imageAssets = [
  'assets/images/logos/open-book.png',
  'assets/images/logos/dna.png',
  'assets/images/logos/art.png',
];
List<String> _titles = ['English Course', 'Biology Course', 'Art Course'];
List<String> _colors = ['#96D3FF', '#FFD27F', '#EFFDB5'];

class ContainerInterestCategories extends StatelessWidget {
  const ContainerInterestCategories({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
      margin: EdgeInsets.only(right: index == 2 ? 0.w : 20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 51.r,
            offset: Offset(11, 13),
            spreadRadius: -8.r,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 54.h,
            width: 54.w,
            decoration: BoxDecoration(
              color: HexColor(_colors[index]),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Image.asset(
                _imageAssets[index],
                width: 16.w,
                height: 16.h,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              _titles[index],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: HexColor('#1A1A1A'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
