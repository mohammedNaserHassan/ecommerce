import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/MyWidgets/CategoryItem.dart';
import 'package:ecommerce/Provider/MyProvider.dart';
import 'package:ecommerce/Services/Router.dart';
import 'package:ecommerce/Ui/ProductDetails.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryTap extends StatelessWidget {
  const CategoryTap();

  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(
      builder: (context, provider, v) => SingleChildScrollView(
        child: SizedBox(
          height: 1000,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: provider.allProducts == null
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            crossAxisAlignment: provider.allProducts == null
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            children: provider.allProducts == null
                ? [
                    Text(
                      'Please Check your internet',
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                    Icon(
                      Icons.wifi_off,
                      color: Colors.grey,
                    )
                  ]
                : [
                    Container(
                        margin: EdgeInsets.all(10),
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25)),
                        child: Image.asset('Assets/Images/promo.png')),
                    Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Text(
                          'HighLights',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: CarouselSlider(
                            options: CarouselOptions(
                              height: 200.0,
                              aspectRatio: 16 / 9,
                              reverse: true,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 5),
                              autoPlayCurve: Curves.easeInOut,
                            ),
                            items: provider.allProducts
                                .map((e) => Container(
                                    margin: EdgeInsets.all(10),
                                    width: 300,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child:
                                        CachedNetworkImage(imageUrl: e.image)))
                                .toList()),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(bottom: 10, left: 20),
                        child: Text(
                          'Categories',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )),
                    provider.allProducts == null
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: provider.allCategories
                                  .map((e) => CategoryItem(
                                        img: e == 'women\'s clothing'
                                            ? 'Assets/Images/girl.jpg'
                                            : e == 'men\'s clothing'
                                                ? 'Assets/Images/boy.jpg'
                                                : e == 'jewelery'
                                                    ? 'Assets/Images/jewelery.jpg'
                                                    : 'Assets/Images/electronic.jpg',
                                        color: provider.selectedCategory == e
                                            ? Colors.red
                                            : Colors.white,
                                        f: () {
                                          provider.getCategoryProducts(e);
                                        },
                                        name:
                                            e[0].toUpperCase() + e.substring(1),
                                      ))
                                  .toList(),
                            ),
                          ),
                    Container(
                      child: provider.categoryProducts == null
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Expanded(
                              flex: 1,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: provider.categoryProducts.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      provider.getSpecificProduct(
                                          provider.categoryProducts[index].id);
                                      AppRouter.appRouter
                                          .gotoPagewithReplacment(
                                              ProductDetails.routeName);
                                    },
                                    child: Container(
                                        margin: EdgeInsets.all(10),
                                        width: 200,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.blue,
                                        ),
                                        padding: EdgeInsets.all(5),
                                        child: Column(children: [
                                          Expanded(
                                            flex: 5,
                                            child: CachedNetworkImage(
                                                imageUrl: provider
                                                    .categoryProducts[index]
                                                    .image,
                                                fit: BoxFit.fill),
                                          ),
                                          Expanded(
                                              flex: 1,
                                              child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 10),
                                                  child: Row(
                                                    children: [
                                                      Text(provider
                                                          .categoryProducts[
                                                              index]
                                                          .title
                                                          .substring(0, 12)),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      Text(
                                                        provider
                                                                .categoryProducts[
                                                                    index]
                                                                .price
                                                                .toString() +
                                                            '\$',
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontWeight:
                                                                FontWeight.w100,
                                                            fontSize: 17),
                                                      )
                                                    ],
                                                  ))),
                                        ])),
                                  );
                                },
                              ),
                            ),
                    )
                  ],
          ),
        ),
      ),
    );
  }
}
