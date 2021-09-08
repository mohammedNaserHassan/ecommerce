import 'package:ecommerce/MyWidgets/CardFavourite.dart';
import 'package:ecommerce/Provider/MyProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class FavouriteTap extends StatelessWidget {
   FavouriteTap();

  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(
      builder: (context,provider,c)=>provider.favouriteProducts==null?Center(
        child: Text('No Favourite yet',style: TextStyle(color: Colors.white),),
      ):ListView.builder(
        itemCount: provider.favouriteProducts.length,
        itemBuilder: (context,index){
          return CardFavourite(
            function: ()async{
              await provider.deleteFavourite(provider.selectedProduct);
              provider.isFavourite=false;
            },
            title: provider.favouriteProducts[index].title,
            imgurl: provider.favouriteProducts[index].image,
            price: provider.favouriteProducts[index].price.toString(),
          );
        },
      ),
    );
  }
}
