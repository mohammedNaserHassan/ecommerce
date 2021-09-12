import 'package:ecommerce/API/ApiHelper.dart';
import 'package:ecommerce/Models/ProductsResponse.dart';
import 'package:ecommerce/MyWidgets/SliderSplach.dart';
import 'package:ecommerce/Authintication/Helper/sqHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyProvider extends ChangeNotifier {
  List<String> allCategories;
  List<ProductResponse> allProducts;
  List<ProductResponse> categoryProducts;
  ProductResponse selectedProduct;
  String selectedCategory = '';

//////////////////////////

  int selected = 0;
  TabController tabController;
  String scafoodName = 'Shopping Store';

  setSelected(int selected) {
    this.selected = selected;
    tabController.animateTo(selected);
    if (selected == 0) {
      this.scafoodName = 'Shopping Store';
    } else if (selected == 1) {
      this.scafoodName = 'My Favourite';
    } else if (selected == 2) {
      this.scafoodName = 'My Cards';
    }
    notifyListeners();
  }

////////////////////////////////////////////////////////////////////////////////////

  ////////////////////////////Favourite////////////////

  List<ProductResponse> favouriteProducts = [];

  getAllFourite() async {
    this.favouriteProducts = await DbHelper.x.getAllProductsFavourite();
    notifyListeners();
  }

  addFavourite(ProductResponse productResponse) async {
    bool productInfavourite =
        favouriteProducts.any((element) => element.id == productResponse.id);
    if (productInfavourite) {
      await DbHelper.x.deleteProductFavourite(productResponse);
    } else {
      await DbHelper.x.insertProductFavourite(productResponse);
      getAllFourite();
    }
  }

  deleteFavourite(ProductResponse productResponse) async {
    await DbHelper.x.deleteProductFavourite(productResponse);
    getAllFourite();
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////////

  double QUT = 0;

  setQuntity(double quntity) {
    QUT += quntity.toDouble();
    notifyListeners();
  }

  desetQuntity(double price) {
      QUT -=price.toDouble();
    notifyListeners();
  }

  ProductResponse getSelected() {
    return this.selectedProduct;
  }

///////////////////////////////////Cards///////////////////////////////////
  List<ProductResponse> cardsProducts = [];

  getAllCards() async {
    this.cardsProducts = await DbHelper.x.getAllProductsCard();
    notifyListeners();
  }

  addCard(ProductResponse productResponse) async {
    bool productInCart = cardsProducts.any((x) {
      return x.id == productResponse.id;
    });
    if (productInCart) {
      productResponse.Quntity = cardsProducts
          .where((element) => element.id == productResponse.id)
          .first
          .Quntity;
      await DbHelper.x.updateProductQuantity(productResponse);
    } else {
      await DbHelper.x.insertProductCard(productResponse);
    }
    getAllCards();
  }

  deleteCard(ProductResponse productResponse) async {
    int quntity = productResponse.Quntity;
    if (quntity > 1) {
      productResponse.Quntity = cardsProducts
          .where((element) => element.id == productResponse.id)
          .first
          .Quntity;
      await DbHelper.x.decrementProductQuantity(productResponse);
    } else {
      await DbHelper.x.deleteProductCard(productResponse);
    }
    getAllCards();
  }

  updateProductInCart(ProductResponse productResponse) async {
    await DbHelper.x.updateProductQuantity(productResponse);
    getAllCards();
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////
  int currentPage = 0;
  PageController controller = PageController();

  onChanged(int index) {
    currentPage = index;
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
    print(allCategories);
    notifyListeners();
    getCategoryProducts(allCategories.first);
  }

  getCategoryProducts(String category) async {
    this.selectedCategory = category;
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
