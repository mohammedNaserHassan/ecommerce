import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/Provider/MyProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'FavouriteIcon.dart';
class CardFavourite extends StatelessWidget {
  String title,price,imgurl;
   CardFavourite({this.title,this.price,this.imgurl});

  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(
      builder: (context,provider,index)=>Card(
        margin: EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.red.withOpacity(0.3))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  width: 100,
                  height: 80,
                  child: CachedNetworkImage(imageUrl:  imgurl)),
              Column(
                children: [
                  Text('Title:\t'+title,style: TextStyle(fontSize: 8),),
                  Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Price:'+price,style: TextStyle(fontSize: 17,color: Colors.red),),
                          SizedBox(width: 110,),
                          FavouriteIcon()
                        ],
                      )),
                ],
              ),
              //icon
            ],
          ),
        ),
      ),
    );
  }
}
