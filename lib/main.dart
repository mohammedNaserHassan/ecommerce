import 'package:ecommerce/Provider/MyProvider.dart';
import 'package:ecommerce/Services/Router.dart';
import 'package:ecommerce/Ui/ProductDetails.dart';
import 'package:ecommerce/Ui/ProfilePage.dart';
import 'package:ecommerce/Ui/SplachScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'AppFire.dart';
import 'Authintication/UI/login.dart';
import 'Authintication/UI/register.dart';
import 'Authintication/UI/resetPassword.dart';
import 'Provider/AuthProvider.dart';
import 'Authintication/Helper/sqHelper.dart';
import 'Ui/HomePage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.x.intiateDatabase();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider<MyProvider>(
          create: (context) => MyProvider(),
        )
      ],
      child: MaterialApp(
        home: App(),
        navigatorKey: AppRouter.appRouter.navkey,
        routes: {
          SplachScreen.routename: (context) => SplachScreen(),
          HomePage.routename: (context) => HomePage(),
          ProductDetails.routeName: (context) => ProductDetails(),
          ProfilePage.routeName: (context) => ProfilePage(),
          Login.routeName: (context) => Login(),
          Register.routeName: (context) => Register(),
          ResetPassword.routeName: (context) => ResetPassword(),
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    ),
  );
}
