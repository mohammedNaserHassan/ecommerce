import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/Provider/MyProvider.dart';
import 'package:ecommerce/Services/Router.dart';
import 'package:ecommerce/Ui/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
  void initState() {
    Provider.of<MyProvider>(context, listen: false).getSelected();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
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
                                provider.selectedProduct.title,
                                style: TextStyle(fontSize: 25),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                width: 200,
                                decoration: BoxDecoration(
                                  color: Colors.cyanAccent,
                                  borderRadius: BorderRadius.circular(15)
                                ),
                                child: Center(
                                  child: Text(
                                    'Description',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                ),
                              ),
                              Text(provider.selectedProduct.description,
                                  style: TextStyle(fontSize: 17)),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RatingBar.builder(
                                    initialRating:
                                        provider.selectedProduct.rating.rate.toDouble(),
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                  Container(
                                    width: 80,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.5),
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    alignment: Alignment.bottomRight,
                                    child: Center(
                                      child: Text(
                                          '\$' +
                                              provider.selectedProduct.price
                                                  .toString(),
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w800)),
                                    ),
                                  ),
                                ],
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
                                      element.id ==
                                          provider.selectedProduct.id ||
                                      provider.favouriteProducts.length == 0)
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
                              }),
                        ),
                        TextButton(
                          onPressed: () async {
                            // await DbHelper.x.getTableNames();
                            await provider.addCard(provider.selectedProduct);
                            Toast.show(
                                "Added to your card successfully", context,
                                duration: Toast.LENGTH_LONG,
                                gravity: Toast.BOTTOM);
                            provider.setQuntity(provider.selectedProduct.price);
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.local_grocery_store,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'Add To Cart',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ],
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
