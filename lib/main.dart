import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_streaming_app/services/auth/auth_methods.dart';
import 'package:flutter_streaming_app/widgets/loading_indicator.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_streaming_app/screens/home_screen.dart';
import 'package:flutter_streaming_app/screens/login_screen.dart';
import 'package:flutter_streaming_app/screens/onboarding_screen.dart';
import 'package:flutter_streaming_app/screens/signup_screen.dart';
import 'package:flutter_streaming_app/services/auth/auth_provider.dart';
import 'package:flutter_streaming_app/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:flutter_streaming_app/services/models/user.dart' as model;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var currentUserUid = FirebaseAuth.instance.currentUser?.uid;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Streaming App',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: primaryTextColor,
        appBarTheme: AppBarTheme.of(context).copyWith(
          backgroundColor: backgroundColor,
          elevation: 0,
          titleTextStyle: const TextStyle(
            color: primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          iconTheme: const IconThemeData(
            color: primaryColor,
          ),
        ),
      ),
      routes: {
        OnBoardingScreen.routeName: (context) => const OnBoardingScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        SignUpScreen.routeName: (context) => const SignUpScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
      },
      home: FutureBuilder(
          future: AuthMethods()
              .getCurrentUser(currentUserUid)
              .then((value) {
            if (value != null) {
              Provider.of<UserProvider>(context, listen: false).setUser(
                model.User.fromMap(value),
              );
            }
            return value;
          }),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState) {
              return const LoadingIndicator();
            }
            if(snapshot.hasData){
              return const HomeScreen();
            }
            return const OnBoardingScreen();
          }),
    );
  }
}
