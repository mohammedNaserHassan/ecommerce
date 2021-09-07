import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRouter{
  AppRouter._();
  static AppRouter appRouter =AppRouter._();
  GlobalKey<NavigatorState> navkey = GlobalKey<NavigatorState>();

  gotoPage(String routeName){
    navkey.currentState.pushNamed(routeName);

  }

  gotoPagewithReplacment(String routeName){
    navkey.currentState.pushReplacementNamed(routeName);

  }

  back(){
    navkey.currentState.pop();
  }
}