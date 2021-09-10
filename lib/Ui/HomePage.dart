import 'package:ecommerce/Provider/AuthProvider.dart';
import 'package:ecommerce/Provider/MyProvider.dart';
import 'package:ecommerce/Services/Dialog.dart';
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
    Provider.of<AuthProvider>(context, listen: false).getUserFromFirestore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(
      builder: (context, provider, index) => Scaffold(
        backgroundColor: Colors.cyan,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.cyan,
          title: Text(
            provider.scafoodName,
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          leading: Builder(
            builder: (context)=>IconButton(
              icon: Icon(
                Icons.menu_rounded,
                color: Colors.white,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: (){
                AppRouter.appRouter.gotoPagewithReplacment(ProfilePage.routeName);
              },
              child: Consumer<AuthProvider>(
                builder: (context,provider,v)=>Container(
                  margin: EdgeInsets.only(right: 15),
                  child: CircleAvatar(
                    backgroundImage:
                    NetworkImage(provider.user.imgurl),
                  ),
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
              Consumer<AuthProvider>(
                builder: (context,provider,v)=> UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
          radius: 100,
          backgroundImage:
          NetworkImage(provider.user.imgurl),
        ),

                  decoration: BoxDecoration(
                    color: Colors.blueGrey
                  ),
                    accountName: Text(provider.user.fName+'\t\t'+provider.user.lName),
                    accountEmail: Text(provider.user.Email)),
              ),
              SizedBox(height: 20,),
              Text('Welcome To Our Store'),
              SizedBox(height: 20,),
              ListTile(
                onTap: (){
                  AppRouter.appRouter.gotoPagewithReplacment(ProfilePage.routeName);
                },
                title: Text('Profile'),
                leading: Icon(Icons.person),
              ),
              ListTile(
                onTap: (){
                  provider.tabController.animateTo(0, duration: Duration(seconds: 0));
                  AppRouter.appRouter.back();
                },
                title: Text('Categories'),
                leading: Icon(Icons.category),
              ),
              ListTile(
                onTap: (){
                  provider.tabController.animateTo(1, duration: Duration(seconds: 1));
                  AppRouter.appRouter.back();
                },
                title: Text('My Favourite'),
                leading: Icon(Icons.favorite),
              ),
              ListTile(
                onTap: (){
                  provider.tabController.animateTo(2, duration: Duration(seconds: 2));
                  AppRouter.appRouter.back();
                },
                title: Text('My Card'),
                leading: Icon(Icons.local_grocery_store),
              ),
              ListTile(
                onTap: (){
                  AppRouter.appRouter.back();
                  showDialog(context: context,
                      builder: (BuildContext context) {
                        return Alert();
                      });
                },
                title: Text('About us'),
                leading: Icon(Icons.more),
              ),
              Consumer<AuthProvider>(
                builder: (context,provider,v)=>ListTile(
                  onTap: (){
                 provider.logOut();
                  },
                  title: Text('Logout'),
                  leading: Icon(Icons.logout),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
