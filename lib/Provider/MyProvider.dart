import 'package:ecommerce/Data/ApiHelper.dart';
import 'package:ecommerce/Models/ProductsResponse.dart';
import 'package:flutter/cupertino.dart';

class MyProvider extends ChangeNotifier{
  List<String> allCategories;
  List<ProductResponse> allProducts;
  List<ProductResponse> categoryProducts;
  ProductResponse selectedProduct;
  getAllCategories() async {
    List<dynamic> categories = await ApiHelper.apiHelper.getAllCategories();
    allCategories = categories.map((e) => e.toString()).toList();
    print(allCategories);
    notifyListeners();
  }

  getCategoryProducts(String category) async {
    List<dynamic> products =
    await ApiHelper.apiHelper.getCategoryProducts(category);
    categoryProducts =
        products.map((e) => ProductResponse.fromJson(e)).toList();
    notifyListeners();
    print(categoryProducts);
  }

  getAllProducts() async {
    List<dynamic> products = await ApiHelper.apiHelper.getAllProducts();
    allProducts = products.map((e) => ProductResponse.fromJson(e)).toList();
    notifyListeners();
    print(allProducts);

  }

  getSpecificProduct(int id) async {
    dynamic response = await ApiHelper.apiHelper.getSpecificProduct(id);
    selectedProduct = ProductResponse.fromJson(response);
    notifyListeners();
    print(selectedProduct.toJson());
  }
}