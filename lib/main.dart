import 'package:edulink_learning_app/controllers/auth_controller/jwt_controller.dart';
import 'package:edulink_learning_app/controllers/user_profile_controller.dart';
import 'package:edulink_learning_app/screens/splash/splash_handler.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<void> main() async {
  // Dibutuhkan setpreferredOrientations.
  WidgetsFlutterBinding.ensureInitialized();

  // Tampilkan splash screen sampai app siap
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Konfigurasi Status Bar dan Navigation Bar
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  // Aplikasi hanya berjalan dalam mode portrait
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Inisialisasi Firebase
  await Firebase.initializeApp();
  // Inisiasi controller

  runApp(const MyApp());
}

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JwtController>(() => JwtController(), fenix: true);
    // Get.lazyPut<UserProfileController>(
    //   () => UserProfileController(),
    //   fenix: true,
    // );
    Get.put(UserProfileController(), permanent: true);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926), // ukuran HP kamu
      minTextAdapt: true,

      child: GetMaterialApp(
        title: 'Edulink',
        theme: ThemeData(fontFamily: 'Montserrat'),
        builder: (context, child) {
          return child!;
        },
        debugShowCheckedModeBanner: false,
        showPerformanceOverlay: false,
        initialRoute: '/',
        initialBinding: HomeBinding(),
        getPages: [GetPage(name: '/', page: () => SplashHandler())],
      ),
    );
  }
}
