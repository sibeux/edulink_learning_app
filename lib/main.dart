import 'package:edulink_learning_app/screens/splash_screen.dart';
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
        getPages: [GetPage(name: '/', page: () => SplashScreen())],
      ),
    );
  }
}
