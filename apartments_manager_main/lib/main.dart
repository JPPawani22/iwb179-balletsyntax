import 'package:flutter/material.dart';
import 'package:apartments_manager_main/fetures/profile/controllers/account_setup_screen_controller.dart';
import 'package:apartments_manager_main/fetures/authentication/controllers/authentication_repository.dart';
import 'package:apartments_manager_main/fetures/authentication/controllers/forgotpassword_controller.dart';
import 'package:apartments_manager_main/fetures/authentication/controllers/login_controller.dart';
import 'package:apartments_manager_main/fetures/authentication/controllers/register_controller.dart';
import 'package:apartments_manager_main/fetures/bookings/controllers/bookings_controller.dart';
import 'package:apartments_manager_main/fetures/bookings/controllers/bookings_repository.dart';
import 'package:apartments_manager_main/fetures/dashboard/controllers/dashboard_controller.dart';
import 'package:apartments_manager_main/fetures/authentication/controllers/onboarding/onboaring_controller.dart';
import 'package:apartments_manager_main/fetures/home/controllers/bottomnavbar_controller.dart';
import 'package:apartments_manager_main/fetures/residents/controllers/residents_controller.dart';
import 'package:apartments_manager_main/fetures/rooms/controllers/rooms_controller.dart';
import 'package:apartments_manager_main/fetures/profile/controllers/user_controller.dart';
import 'package:apartments_manager_main/fetures/authentication/screens/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyBUW30KcgMfmfMr7z6irFLCz9G9Dcv9Amw",
        appId: "1:721358647180:android:8bba875f4f26ea2a8470a9",
        messagingSenderId: '721358647180',
        projectId: "hostel-management-app-4ae0f",
        storageBucket: "hostel-management-app-4ae0f.appspot.com"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => OnBoardingController(),
        ),
        ChangeNotifierProvider(
          create: (context) => NavBarController(),
        ),
        ChangeNotifierProvider(
          create: (context) => ResidentsController(),
        ),
        ChangeNotifierProvider(
          create: (context) => AccountSetUpScreenController(),
        ),
        ChangeNotifierProvider(
          create: (context) => SignInController(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthenticationRepository(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginController(),
        ),
        ChangeNotifierProvider(
          create: (context) => ForgotPasswordController(),
        ),
        ChangeNotifierProvider(
          create: (context) => DashboardController(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserController(),
        ),
        ChangeNotifierProvider(
          create: (context) => RoomsController(),
        ),
        ChangeNotifierProvider(
          create: (context) => BookingRepository(),
        ),
        ChangeNotifierProvider(
          create: (context) => BookingsController(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}

class AnnouncementScreen extends StatelessWidget {
  const AnnouncementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Placeholder for fetching and displaying announcements
    return Scaffold(
      appBar: AppBar(
        title: Text('Announcements'),
      ),
      body: Center(
        child: Text('No announcements available.'),
      ),
    );
  }
}
