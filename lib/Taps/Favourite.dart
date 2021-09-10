import 'package:ecommerce/MyWidgets/CardFavourite.dart';
import 'package:ecommerce/Provider/MyProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouriteTap extends StatefulWidget {
  FavouriteTap();

  @override
  _FavouriteTapState createState() => _FavouriteTapState();
}

class _FavouriteTapState extends State<FavouriteTap> {
  @override
  void initState() {
    Provider.of<MyProvider>(context, listen: false).getAllFourite();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(
      builder: (context, provider, c) => provider.favouriteProducts.length == 0
          ? Center(
              child: Text(
                'No Favourite yet',
                style: TextStyle(color: Colors.white),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: provider.favouriteProducts.length,
                    itemBuilder: (context, index) {
                      return CardFavourite(
                        function: () async {
                          await provider.deleteFavourite(
                              provider.favouriteProducts[index]);
                        },
                        title: provider.favouriteProducts[index].title
                            .substring(0, 25),
                        imgurl: provider.favouriteProducts[index].image,
                        price:
                            provider.favouriteProducts[index].price.toString(),
                      );
                    },
                  ),
                ),

              ],
            ),
    );
  }
}
