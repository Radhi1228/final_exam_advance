import 'package:final_exam_ad/screen/cart/view/cart_screen.dart';
import 'package:final_exam_ad/screen/home/view/home_screen.dart';
import 'package:final_exam_ad/screen/splash/view/splash_screen.dart';
import 'package:flutter/cupertino.dart';

Map<String,WidgetBuilder> appRoutes = {

  '/' : (c1) => const SplashScreen(),
  '/home' : (c1) => const HomeScreen(),
  '/cart' : (c1) => const CartScreen(),
};