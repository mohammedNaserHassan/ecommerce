import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/Provider/MyProvider.dart';
import 'package:ecommerce/Services/Router.dart';
import 'package:ecommerce/Ui/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class ProductDetails extends StatefulWidget {
  static final routeName = 'details';

  ProductDetails();

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.cyan,
        title: Row(
          children: [
            IconButton(
                onPressed: () {
                  AppRouter.appRouter
                      .gotoPagewithReplacment(HomePage.routename);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                )),
            Text(
              'Product Details',
              style: TextStyle(color: Colors.white),
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
                          child: IconButton(
                            icon: provider.favouriteProducts.any((element) =>
                                    element.id == provider.selectedProduct.id||provider.favouriteProducts.length==0)
                                ? Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                : Icon(
                                    Icons.favorite_outline,
                                    color: Colors.red,
                                  ),
                            onPressed: () async {
                                    provider.addFavourite(provider.selectedProduct);
                              }
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            // await DbHelper.x.getTableNames();
                            await provider.addCard(provider.selectedProduct);
                            provider.setQuntity(provider.selectedProduct.price,provider.selectedProduct.Quntity);
                            Toast.show(
                                "Added to your card successfully", context,
                                duration: Toast.LENGTH_LONG,
                                gravity: Toast.LENGTH_SHORT);
                          },
                          child: Container(
                              margin: EdgeInsets.all(8),
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.amber),
                              width: 290,
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
