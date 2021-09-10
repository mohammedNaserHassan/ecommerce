import 'package:ecommerce/Provider/AuthProvider.dart';
import 'package:ecommerce/Provider/MyProvider.dart';
import 'package:ecommerce/Services/Router.dart';
import 'package:ecommerce/Ui/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplachScreen extends StatefulWidget {
  static final routename = 'Splash';

  SplachScreen();

  @override
  _SplachScreenState createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {

  @override
  void initState() {
    Provider.of<MyProvider>(context, listen: false).getAllCategories();
    Provider.of<MyProvider>(context, listen: false).getAllProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer2<MyProvider,AuthProvider>(
        builder:(context,provider,provider2,x)=> Stack(
          children: <Widget>[
            PageView.builder(
              scrollDirection: Axis.horizontal,
              onPageChanged: (index){
                provider.onChanged(index);
              },
              controller: provider.controller,
              itemCount: provider.pages.length,
              itemBuilder: (context, int index) {
                return provider.pages[index];
              },
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(provider.pages.length, (int index) {
                      return AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          height: 10,
                          width: (index == provider.currentPage) ? 30 : 10,
                          margin:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 30),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: (index == provider.currentPage)
                                  ? Colors.blueGrey
                                  : Colors.blue.withOpacity(0.5)));
                    })),
                InkWell(
                  onTap: () {
                    provider.controller.nextPage(
                        duration: Duration(milliseconds: 800),
                        curve: Curves.easeInOutQuint);
                  },
                  child: AnimatedContainer(
                    alignment: Alignment.center,
                    duration: Duration(milliseconds: 300),
                    height: 70,
                    width: (provider.currentPage == (provider.pages.length - 1)) ? 200 : 75,
                    decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(35)),
                    child: (provider.currentPage == (provider.pages.length - 1))
                        ? TextButton(
                      onPressed: (){
                        provider2.checkLogin();
                      },
                          child: Text(
                      "Get Started",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                      ),
                    ),
                        )
                        : Icon(
                      Icons.navigate_next,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          ],
        ),
      ),
    );


  }
}
