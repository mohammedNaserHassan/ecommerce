import 'package:ecommerce/Data/ApiHelper.dart';
import 'package:ecommerce/Models/ProductsResponse.dart';
import 'package:ecommerce/MyWidgets/SliderSplach.dart';
import 'package:ecommerce/Services/sqHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyProvider extends ChangeNotifier{
  List<String> allCategories;
  List<ProductResponse> allProducts;
  List<ProductResponse> categoryProducts;
  ProductResponse selectedProduct;
String selectedCategory='';
//////////////////////////

  int selected = 0;
  TabController tabController;
  setSelected(int selected) {
    this.selected = selected;
    tabController.animateTo(selected);
    notifyListeners();
  }
////////////////////////////////////////////////////////////////////////////////////

  ////////////////////////////Favourite////////////////

  List<ProductResponse> favouriteProducts;

getAllFourite()async{
  this.favouriteProducts= await DbHelper.x.getAllProductsFavourite();
  notifyListeners();
}

addFavourite(ProductResponse productResponse)async{
await DbHelper.x.insertProductFavourite(productResponse);
getAllFourite();
}

deleteFavourite(ProductResponse productResponse)async{
await DbHelper.x.deleteProductFavourite(productResponse);
getAllFourite();
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////


///////////////////////////////////Cards///////////////////////////////////
  List<ProductResponse> cardsProducts;

  getAllCards()async{
    this.cardsProducts= await DbHelper.x.getAllProductsCard();
    notifyListeners();
  }

  addCard(ProductResponse productResponse)async{
    await DbHelper.x.insertProductCard(productResponse);
    getAllCards();
  }

  deleteCard(ProductResponse productResponse)async{
    await DbHelper.x.deleteProductCard(productResponse);
    getAllCards();
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////

bool isFavourite= false;
  selectFavourite(){
    this.isFavourite=!this.isFavourite;
    notifyListeners();
  }
  /////////////
  int currentPage = 0;
  PageController controller = PageController();
  onChanged(int index){
    currentPage=index;
    notifyListeners();
  }

  List<Widget> pages = [
    SliderPage(
        title: "Keep && Search",
        description:
        "Accept cryptocurrencies and digital assets, keep thern here, or send to orthers",
        image: "Assets/Images/s1.svg"),
    SliderPage(
        title: "Browse",
        description:
        "Browse your Products cryptocurrencies or Change with orthres digital assets or flat money",
        image: "Assets/Images/s3.svg"),
    SliderPage(
        title: "Buy",
        description:
        "Buy Products and cryptocurrencies with VISA and MasterVard right in the App",
        image: "Assets/Images/s2.svg"),
  ];
  /////////////////////////

  getAllCategories() async {
    List<dynamic> categories = await ApiHelper.apiHelper.getAllCategories();
    allCategories = categories.map((e) => e.toString()).toList();
    notifyListeners();
    getCategoryProducts(allCategories.first);
  }

  getCategoryProducts(String category) async {
    this.selectedCategory=category;
    List<dynamic> products =
    await ApiHelper.apiHelper.getCategoryProducts(category);
    categoryProducts =
        products.map((e) => ProductResponse.fromJson(e)).toList();
    notifyListeners();
  }

  getAllProducts() async {
    List<dynamic> products = await ApiHelper.apiHelper.getAllProducts();
    allProducts = products.map((e) => ProductResponse.fromJson(e)).toList();
    notifyListeners();

  }

  getSpecificProduct(int id) async {
    dynamic response = await ApiHelper.apiHelper.getSpecificProduct(id);
    selectedProduct = ProductResponse.fromJson(response);
    notifyListeners();
  }
}