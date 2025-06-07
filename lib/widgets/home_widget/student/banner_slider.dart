import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/controllers/banner_slider_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerSlider extends StatelessWidget {
  const BannerSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final bannerSliderController = Get.put(BannerSliderController());
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 180.h,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(25.r),
          ),
          child: PageView.builder(
            // itemCount: 5, // Hapus ini jika tidak ingin ada batasan.
            controller: bannerSliderController.pageController.value,
            onPageChanged: (index) {
              bannerSliderController.onPageChanged(index);
            },
            itemBuilder: (context, index) {
              return Image.asset(
                'assets/images/screens/home/student-carousel-img-${(index % 3) + 1}.png',
                fit: BoxFit.cover,
                height: 180.h,
                width: double.infinity,
                filterQuality: FilterQuality.high,
              );
            },
          ),
        ),
        SizedBox(height: 15.h),
        Center(
          child: SmoothPageIndicator(
            controller: bannerSliderController.pageController.value,
            count: 3,
            effect: ScrollingDotsEffect(
              activeDotColor: ColorPalette().primary,
              dotColor: HexColor('#E5ECFF'),
              activeDotScale: 1.5,
              dotHeight: 5.h,
              dotWidth: 5.w,
              spacing: 6.w,
            ),
          ),
        ),
      ],
    );
  }
}
