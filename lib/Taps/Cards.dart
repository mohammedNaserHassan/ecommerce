import 'package:ecommerce/MyWidgets/CardFavourite.dart';
import 'package:ecommerce/MyWidgets/CardofCards.dart';
import 'package:ecommerce/MyWidgets/CustomButton.dart';
import 'package:ecommerce/MyWidgets/Custom_textfield.dart';
import 'package:ecommerce/Provider/MyProvider.dart';
import 'package:ecommerce/Services/Dialog.dart';
import 'package:ecommerce/Services/Router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class CardTap extends StatefulWidget {
   CardTap();

  @override
  _CardTapState createState() => _CardTapState();
}

class _CardTapState extends State<CardTap> {
  @override
  void initState() {
Provider.of<MyProvider>(context,listen: false).getAllCards();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(
      builder: (context,provider,c)=>provider.cardsProducts.length==0?Center(
        child: Text('No Cards yet',style: TextStyle(color: Colors.white),),
      ):Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: provider.cardsProducts.length,
              itemBuilder: (context,index){
                return CardofCards(
                  title: provider.cardsProducts[index].Quntity.toString(),
                  imgurl: provider.cardsProducts[index].image,
                  price: provider.cardsProducts[index].price.toString(),
                  function: ()async{
                    provider.deleteCard(provider.cardsProducts[index]);
                    provider.desetQuntity(provider.cardsProducts[index].price, provider.cardsProducts[index].Quntity);
                  },
                );
              },
            ),
          ),
          Container(
              child: Text(
                'Total\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\$'+provider.QUT.toString(),
                style: TextStyle(fontSize: 25, color: Colors.black),
              )),
          TextButton(
            onPressed: (){
              showDialog(context: context, builder: (context)=>Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                ),
              child: Container(
                color: Colors.grey,
                width: 300,
                height: 400,
                child: Column(
                  children: [
                   CircleAvatar(
                     radius: 80,
                     backgroundImage: AssetImage('Assets/Images/cc.jpg'),
                   ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10,top: 10),
                        color: Colors.white,
                        child: Custom_textfield(label: 'Enter your name',)),
                    Container(
                        color: Colors.white,
                        child: Custom_textfield(label: 'Enter your card number',type: TextInputType.number,)),
                  Container(
                    width: 200,
                    height: 60,
                    color: Colors.red,
                      margin: EdgeInsets.only(top: 20),
                      child: CustomButton(label: 'Pay bill',function: (){
                        AppRouter.appRouter.back();
                      },))
                  ],
                ),
              ),
              ));
            },
            child: Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(20),
              width: 300,
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black),
              child: Center(
                  child: Text(
                    'Checkout',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold,fontSize: 25),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
