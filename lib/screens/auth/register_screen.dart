import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/controllers/auth_controller/register_controller.dart';
import 'package:edulink_learning_app/screens/auth/login_screen.dart';
import 'package:edulink_learning_app/widgets/auth_widget/auth_form/register_form/email_register_form.dart';
import 'package:edulink_learning_app/widgets/auth_widget/auth_form/register_form/name_register_form.dart';
import 'package:edulink_learning_app/widgets/auth_widget/auth_form/register_form/number_register_form.dart';
import 'package:edulink_learning_app/widgets/auth_widget/auth_form/register_form/password_register_form.dart';
import 'package:edulink_learning_app/widgets/auth_widget/user_type_select.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../widgets/auth_widget/auth_button/auth_button.dart';
import '../../widgets/auth_widget/auth_button/register_button/register_submit_disable.dart';
import '../../widgets/auth_widget/auth_button/register_button/register_submit_enable.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final registerController = Get.put(RegisterController());

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    registerController.changeIndexUserType(0);
    super.initState();

    _tabController.addListener(() {
      registerController.changeIndexUserType(_tabController.index);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          titleSpacing: 0,
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios_new,
              color: ColorPalette().primary,
            ),
          ),
          title: Text(
            "Sign Up",
            style: TextStyle(
              color: HexColor("#000000"),
              fontSize: 32.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: (268 * 0.7).w,
                height: (277 * 0.7).h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/screens/register.png"),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 25.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: TabBar(
                  indicatorColor: ColorPalette().primary,
                  labelColor: ColorPalette().primary,
                  dividerColor: Colors.transparent,
                  indicatorWeight: 5,
                  labelPadding: EdgeInsets.zero,
                  controller: _tabController,
                  onTap: (value) {
                    registerController.changeIndexUserType(value);
                  },
                  tabs: [
                    Tab(
                      child: UserTypeSelect(
                        title: 'Student',
                        index: 0,
                        authController: registerController,
                      ),
                    ),
                    Tab(
                      child: UserTypeSelect(
                        title: 'Tutor',
                        index: 1,
                        authController: registerController,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 35.h),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 40.w),
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Full Name",
                      style: TextStyle(
                        color: ColorPalette().primary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 7.h),
                    NameRegisterForm(),
                    SizedBox(height: 25.h),
                    Text(
                      "Email",
                      style: TextStyle(
                        color: ColorPalette().primary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 7.h),
                    EmailRegisterForm(),
                    SizedBox(height: 25.h),
                    Text(
                      "Password",
                      style: TextStyle(
                        color: ColorPalette().primary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 7.h),
                    PasswordRegisterForm(),
                    SizedBox(height: 25.h),
                    Text(
                      "Phone Number",
                      style: TextStyle(
                        color: ColorPalette().primary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 7.h),
                    NumberRegisterForm(),
                  ],
                ),
              ),
              SizedBox(height: 40.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => Checkbox(
                      checkColor: Colors.white,
                      activeColor: ColorPalette().primary,
                      focusColor: ColorPalette().primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      side: BorderSide(
                        color:
                            registerController.isCheckboxChecked.value
                                ? ColorPalette().primary
                                : Colors.grey,
                        width: 1.5.w,
                      ),
                      value: registerController.isCheckboxChecked.value,
                      onChanged: (value) {
                        registerController.isCheckboxChecked.value =
                            value ?? false;
                      },
                    ),
                  ),
                  RichText(
                    maxLines: 2,
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'I agree to the ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: 'Privacy Policy and Terms',
                          style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                        TextSpan(
                          text: '\nand conditions by ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: 'Edulink',
                          style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Obx(
                () =>
                    registerController.getIsDataRegisterValid() &&
                            !registerController.getIsNameValid() &&
                            registerController.isCheckboxChecked.value
                        ? registerController.isLoading.value
                            ? const AbsorbPointer(child: AuthButtonLoading())
                            : RegisterSubmitButtonEnable()
                        : const AbsorbPointer(
                          child: RegisterSubmitButtonDisable(),
                        ),
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 5.w),
                  GestureDetector(
                    onTap: () {
                      Get.off(
                        () => LoginScreen(),
                        transition: Transition.leftToRight,
                        duration: const Duration(milliseconds: 300),
                        fullscreenDialog: true,
                        popGesture: false,
                      );
                    },
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: ColorPalette().primary,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 60.h),
            ],
          ),
        ),
      ),
    );
  }
}
