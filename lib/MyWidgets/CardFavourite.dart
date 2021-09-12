import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/Provider/MyProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardFavourite extends StatelessWidget {
  String title, price, imgurl;
  Function function;

  CardFavourite({this.title, this.price, this.imgurl, this.function});

  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(
      builder: (context, provider, index) => Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.redAccent.withOpacity(0.5),
            border: Border.all(color: Colors.red.withOpacity(0.5),)
        ,borderRadius: BorderRadius.circular(15)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
                width: 100,
                height: 80,
                child: CachedNetworkImage(imageUrl: imgurl)),
            Column(
              children: [
                Container(
                    margin: EdgeInsets.only(right: 50),
                    child: Text(
                      title,
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    )),
                Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Text(
                          price + '\$',
                          style: TextStyle(fontSize: 17, color: Colors.red),
                        ),
                        SizedBox(
                          width: 110,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                          onPressed: function,
                        ),
                      ],
                    )),
              ],
            ),
            //icon
          ],
        ),
      ),
    );
  }
}
