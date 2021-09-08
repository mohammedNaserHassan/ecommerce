import 'package:ecommerce/Provider/MyProvider.dart';
import 'package:ecommerce/Services/Router.dart';
import 'package:ecommerce/Ui/ProductDetails.dart';
import 'package:ecommerce/Ui/ProfilePage.dart';
import 'package:ecommerce/Ui/SplachScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Services/sqHelper.dart';
import 'Ui/HomePage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.x.intiateDatabase();
  runApp(
    ChangeNotifierProvider<MyProvider>(
      create: (context)=>MyProvider(),
      child: MaterialApp(
        navigatorKey: AppRouter.appRouter.navkey,
        initialRoute: SplachScreen.routename,
routes: {
  SplachScreen.routename: (context) => SplachScreen(),
  HomePage.routename: (context) => HomePage(),
  ProductDetails.routeName: (context) => ProductDetails(),
  ProfilePage.routeName: (context) => ProfilePage(),
},
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
  ));
}
