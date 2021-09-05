import 'package:ecommerce/Data/ApiHelper.dart';
import 'package:ecommerce/Models/ProductsResponse.dart';
import 'package:ecommerce/Provider/MyProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class HomePage extends StatelessWidget {
  const HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  title: Text('Ecommerce'),
),
      body:Consumer<MyProvider>(
        builder: (context,provider,c)=>RaisedButton(
          onPressed: () async {
            provider.getAllCategories();
          },
        ),
      ),
    );
  }
}
