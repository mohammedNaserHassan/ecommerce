import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/MyWidgets/CategoryItem.dart';
import 'package:ecommerce/Provider/MyProvider.dart';
import 'package:ecommerce/Services/Router.dart';
import 'package:ecommerce/Taps/Cards.dart';
import 'package:ecommerce/Taps/Category.dart';
import 'package:ecommerce/Taps/Favourite.dart';
import 'package:ecommerce/Ui/ProductDetails.dart';
import 'package:ecommerce/Ui/ProfilePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static final routename = 'Home';

  HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final List<Widget> _children = [CategoryTap(), FavouriteTap(), CardTap()];

  @override
  void initState() {
    Provider.of<MyProvider>(context, listen: false).tabController =
        TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(
      builder: (context, provider, index) => Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blueGrey,
          title: Text(
            'Shopping',
            style: TextStyle(color: Colors.cyan),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.line_weight_sharp,
              color: Colors.grey,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
          actions: [
            GestureDetector(
              onTap: (){
                AppRouter.appRouter.gotoPagewithReplacment(ProfilePage.routeName);
              },
              child: Container(
                margin: EdgeInsets.only(right: 15),
                child: CircleAvatar(
                  radius: 15,
                  backgroundImage: NetworkImage(
                      'https://media.istockphoto.com/photos/portrait-t'
                      'eenager-picture-id846730696?b=1&k=20&m=846730696&s=170x170&h=CZ4DDXLVr7-cV19'
                      'JbL8HM2GTZ8lJrMMFqOd7eFWzAyU='),
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: provider.selected,
            onTap: (select) {
              provider.setSelected(select);
            },
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.category,
                  ),
                  label: 'Category'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite,
                  ),
                  label: 'Favourite'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.shopping_basket,
                  ),
                  label: 'Card'),
            ]),
        body: Consumer<MyProvider>(
          builder: (context, provider, c) => DefaultTabController(
            length: 3,
            child: TabBarView(
              controller: provider.tabController,
              children: _children,
            ),
          ),
        ),
        drawer: Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blueGrey
                ),
                otherAccountsPictures: [
                  Icon(Icons.person)
                ],
                  accountName: Text('Mohammed'),
                  accountEmail: Text('Shoakk2015@gmail.com')),
              SizedBox(height: 20,),
              Text('Welcome To Our Store'),
              SizedBox(height: 20,),
              ListTile(
                title: Text('Profile'),
                leading: Icon(Icons.person),
              ),
              ListTile(
                title: Text('Categories'),
                leading: Icon(Icons.category),
              ),
              ListTile(
                title: Text('My Favourite'),
                leading: Icon(Icons.favorite),
              ),
              ListTile(
                title: Text('My Card'),
                leading: Icon(Icons.local_grocery_store),
              ),
              ListTile(
                title: Text('About'),
                leading: Icon(Icons.more),
              ),
              ListTile(
                title: Text('Logout'),
                leading: Icon(Icons.logout),
              )
            ],
          ),
        ),
      ),
    );
  }
}
