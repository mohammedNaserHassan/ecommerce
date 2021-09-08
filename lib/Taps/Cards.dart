import 'package:ecommerce/MyWidgets/CardFavourite.dart';
import 'package:ecommerce/Provider/MyProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class CardTap extends StatelessWidget {
   CardTap();

  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(
      builder: (context,provider,c)=>provider.cardsProducts==null?Center(
        child: Text('No Cards yet',style: TextStyle(color: Colors.white),),
      ):SingleChildScrollView(
        child: ListView.builder(
          itemCount: provider.cardsProducts.length,
          itemBuilder: (context,index){
            return CardFavourite(
              title: provider.cardsProducts[index].title,
              imgurl: provider.cardsProducts[index].image,
              price: provider.cardsProducts[index].price.toString(),
            );
          },
        ),
      ),
    );
  }
}
