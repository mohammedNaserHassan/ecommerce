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
      builder: (context, provider, v) => Column(
        mainAxisAlignment:  provider.allProducts==null?MainAxisAlignment.center:MainAxisAlignment.start,
        crossAxisAlignment: provider.allProducts==null?CrossAxisAlignment.center:CrossAxisAlignment.start,
        children: provider.allProducts==null?[
        Text('Please Check your internet',style: TextStyle(fontSize: 20,),),
          Icon(Icons.wifi_off)
        ]:[
          Container(
            margin: EdgeInsets.all(20),
            width: 350,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15)
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                border: InputBorder.none,
                prefix: Icon(Icons.search,color: Colors.grey,)
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 20),
              child: Text('Highights',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            color: Colors.black54.withOpacity(0.1),
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
                    child: CachedNetworkImage(imageUrl: e.image)))
                    .toList()),
          ),
          Container(
              margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
              child: Text('Categories',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
          Container(
            height: 70,
            child: provider.allProducts == null
                ? Center(
              child: CircularProgressIndicator(),
            )
                : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: provider.allCategories
                    .map((e) => CategoryItem(
                  color: provider.selectedCategory == e
                      ? Colors.red
                      : Colors.white,
                  f: () {
                    provider.getCategoryProducts(e);
                  },
                  name: e[0].toUpperCase() + e.substring(1),
                ))
                    .toList(),
              ),
            ),
          ),
          Container(
            child: provider.categoryProducts == null
                ? Center(
              child: CircularProgressIndicator(),
            )
                : Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: provider.categoryProducts.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      provider.getSpecificProduct(provider.categoryProducts[index].id);
                      AppRouter.appRouter.gotoPagewithReplacment(ProductDetails.routeName);
                    },
                    child: Container(
                      margin: EdgeInsets.all(20),
                      width: 350,
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white
                        ),
                        padding: EdgeInsets.all(5),
                        child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: CachedNetworkImage(
                                    imageUrl: provider
                                        .categoryProducts[index].image),
                              ),
                              Text('This is\t' +
                                  provider
                                      .categoryProducts[index].title),
                              SizedBox(height: 5,),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Text('Price:\t' +
                                    provider.categoryProducts[index].price
                                        .toString() +
                                    '\$',style: TextStyle(color: Colors.red,fontSize: 20),),
                              ),
                            ])),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
