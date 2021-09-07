import 'package:ecommerce/Provider/MyProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class CategoryItem extends StatelessWidget {
  String name;
  Function f;
  Color color;
   CategoryItem({this.name,this.f,this.color});

  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(
      builder: (context,provider,x)=>GestureDetector(
        onTap: f,
        child: FittedBox(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
            width: 200,
            height: 50,
            decoration: BoxDecoration(
              color:color,
              borderRadius: BorderRadius.circular(15)
            ),
            child: Center(child: Text(name,style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold
            ),)),
          ),
        ),
      ),
    );
  }
}
