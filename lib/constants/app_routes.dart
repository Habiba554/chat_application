
import 'package:chat_app/views/screens/home.dart';
import 'package:chat_app/views/screens/login_screen.dart';
import 'package:chat_app/views/screens/profile_page.dart';
import 'package:chat_app/views/screens/signup_screen.dart';
import 'package:chat_app/views/screens/splash_screen.dart';
import 'package:flutter/material.dart';



class Routes {
  static const String splashRoute = '/';
  static const String homeRoute = '/home';
  static const String loginRoute = '/login';
  static const String signUpRoute = '/signUp';
  static const String chatPageRoute='/chat';
  static const String profileRoute='/profile';

  static Route? getRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute(
          builder: (context) {
        return const SplashScreen();
          },
        );
      case loginRoute:
        return MaterialPageRoute(
          builder: (context) {
            return  LoginScreen();
          },
        );

      case signUpRoute:
        return MaterialPageRoute(
          builder: (context) =>  SignupScreen(),
        );
      case homeRoute:
        return MaterialPageRoute(
          builder: (context) =>  const HomeScreen(),
        );
      case profileRoute:
       return MaterialPageRoute(
          builder: (context) =>  const ProfilePage(),
        );
      default:
       return MaterialPageRoute(
          builder: (context) =>  const HomeScreen(),
        );
    }
  }
  }