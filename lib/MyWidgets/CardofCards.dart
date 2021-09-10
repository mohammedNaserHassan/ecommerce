import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/Provider/MyProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardofCards extends StatelessWidget {
  String title, price, imgurl;
  Function function;
  int priceContainer;

  CardofCards({this.title, this.price, this.imgurl,this.function,this.priceContainer});

  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(
      builder: (context, provider, index) => Card(
        margin: EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.red.withOpacity(0.3))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  width: 100,
                  height: 80,
                  child: CachedNetworkImage(imageUrl: imgurl)),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(right:150,top: 15),
                    child: Text(
                      'QNT:\t' + title,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              'Price:' + price,
                              style: TextStyle(fontSize: 17, color: Colors.red),
                            ),
                          ),
                          SizedBox(
                            width: 110,
                          ),
                          IconButton(onPressed: function, icon: Icon(Icons.delete))
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
