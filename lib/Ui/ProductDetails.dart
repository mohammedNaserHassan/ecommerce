import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/Provider/MyProvider.dart';
import 'package:ecommerce/Services/Router.dart';
import 'package:ecommerce/Services/sqHelper.dart';
import 'package:ecommerce/Ui/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatelessWidget {
  static final routeName = 'details';

  ProductDetails();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueGrey,
        title: Row(
          children: [
            IconButton(
                onPressed: () {
                  AppRouter.appRouter
                      .gotoPagewithReplacment(HomePage.routename);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.cyan,
                )),
            Text(
              'Product Details',
              style: TextStyle(color: Colors.cyan),
            ),
          ],
        ),
      ),
      body: Consumer<MyProvider>(
        builder: (context, provider, index) => provider.selectedProduct == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(vertical: 12),
                        child: CachedNetworkImage(
                          imageUrl: provider.selectedProduct.image,
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Text(
                                'Title: ' + provider.selectedProduct.title,
                                style: TextStyle(fontSize: 25),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                  'Description: ' +
                                      provider.selectedProduct.description,
                                  style: TextStyle(fontSize: 17)),
                              SizedBox(
                                height: 10,
                              ),
                              Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                      'Rating:' +
                                          provider.selectedProduct.rating.rate
                                              .toString(),
                                      style: TextStyle(fontSize: 25))),
                              SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                    'Price: ' +
                                        provider.selectedProduct.price
                                            .toString(),
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.redAccent,
                                        fontWeight: FontWeight.w800)),
                              ),
                            ],
                          ),
                        )),
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await DbHelper.x.getTableNames();
                          },
                          child: Container(
                              margin: EdgeInsets.all(10),
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                vertical: 15,
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.greenAccent),
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.cyan),
                              width: 300,
                              child: Text(
                                'Add To Cart',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
