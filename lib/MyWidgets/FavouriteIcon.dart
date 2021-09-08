import 'package:ecommerce/Provider/MyProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class FavouriteIcon extends StatelessWidget {
  const FavouriteIcon();

  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(
      builder: (context,provider,v)=>IconButton(
        icon: provider.isFavourite?Icon(Icons.favorite,color: Colors.red,):Icon(
          Icons.favorite_outline,
          color: Colors.red,
        ),
        onPressed: (){
          provider.selectFavourite();
        },
      ),
    );
  }
}
