import 'package:ecommerce/Data/ApiHelper.dart';
import 'package:ecommerce/Models/ProductsResponse.dart';
import 'package:flutter/material.dart';
class HomePage extends StatelessWidget {
  const HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  title: Text('Ecommerce'),
),
      body: RaisedButton(
        child: Text('Show single product'),
        onPressed: ()async{
          Product product = await ApiHelper.apiHelper.getSingleProduct('1');
          print('h');
          print(product.title);
        },
      ),
    );
  }
}
