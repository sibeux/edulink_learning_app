import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/controllers/auth_controller/login_controller.dart';
import 'package:edulink_learning_app/screens/auth/register_auth/register_screen.dart';
import 'package:edulink_learning_app/widgets/auth_widget/auth_button/login_button/login_submit_disable.dart';
import 'package:edulink_learning_app/widgets/auth_widget/auth_button/login_button/login_submit_enable.dart';
import 'package:edulink_learning_app/widgets/auth_widget/auth_form/login_form/email_login_form.dart';
import 'package:edulink_learning_app/widgets/auth_widget/auth_form/login_form/password_login_form.dart';
import 'package:edulink_learning_app/widgets/auth_widget/user_type_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../widgets/auth_widget/auth_button/auth_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final loginController = Get.put(LoginController());

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    loginController.changeIndexUserType(0);
    super.initState();

    _tabController.addListener(() {
      loginController.changeIndexUserType(_tabController.index);
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
        resizeToAvoidBottomInset: false,
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
            "Login",
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
                    image: AssetImage("assets/images/screens/login.png"),
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
                    loginController.changeIndexUserType(value);
                  },
                  tabs: [
                    Tab(
                      child: UserTypeSelect(
                        title: 'Student',
                        index: 0,
                        authController: loginController,
                      ),
                    ),
                    Tab(
                      child: UserTypeSelect(
                        title: 'Tutor',
                        index: 1,
                        authController: loginController,
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
                      "Email",
                      style: TextStyle(
                        color: ColorPalette().primary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 7.h),
                    EmailLoginForm(),
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
                    PasswordLoginForm(),
                    SizedBox(height: 22.h),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Obx(
                            () =>
                                !loginController.isLoginSuccess.value
                                    ? Text(
                                      '*Email or Password is incorrect',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.red.withValues(alpha: 1),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                    : const SizedBox(),
                          ),
                          Spacer(),
                          Text(
                            'Forgot Password?',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: ColorPalette().primary,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 100.h),
              Obx(
                () =>
                    loginController.getIsDataLoginValid()
                        ? loginController.isLoading.value
                            ? const AbsorbPointer(child: AuthButtonLoading())
                            : const LoginSubmitButtonEnable()
                        : const AbsorbPointer(
                          child: LoginSubmitButtonDisable(),
                        ),
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have any account?',
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
                        () => const RegisterScreen(),
                        transition: Transition.rightToLeft,
                        duration: const Duration(milliseconds: 300),
                        fullscreenDialog: true,
                        popGesture: false,
                      );
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: ColorPalette().primary,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
