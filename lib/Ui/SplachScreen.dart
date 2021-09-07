import 'package:ecommerce/Provider/MyProvider.dart';
import 'package:ecommerce/Services/Router.dart';
import 'package:ecommerce/Ui/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class SplachScreen extends StatefulWidget {
  static final routename = 'Splash';
   SplachScreen();

  @override
  _SplachScreenState createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  @override
  void initState() {
   Provider.of<MyProvider>(context,listen: false).getAllCategories();
   Provider.of<MyProvider>(context,listen: false).getAllProducts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2)).then((value) => AppRouter.appRouter.gotoPagewithReplacment(HomePage.routename));
    return Scaffold(
      body: Center(
        child: FlutterLogo(),
      ),
    );
  }
}
