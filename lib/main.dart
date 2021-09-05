import 'package:ecommerce/Provider/MyProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Ui/HomePage.dart';

void main() {
  runApp(
    ChangeNotifierProvider<MyProvider>(
      create: (context)=>MyProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
  ));
}
