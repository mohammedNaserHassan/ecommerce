import 'package:dio/dio.dart';
import 'package:ecommerce/Models/ProductsResponse.dart';

class ApiHelper{
  ApiHelper._();
  static ApiHelper apiHelper = ApiHelper._();

  Dio dio=Dio();
////////////////////////////////////////////////////////////
 Future<List<String>> getAllCategories()async{
    String url='https://fakestoreapi.com/products/categories';
    Response response=await dio.get(url);
    List<dynamic> categores = response.data;
    return categores.map((e) => e).toList();
  }
  //////////////////////////////////////////////////////////////////

  getCategoryProduts(String categoryname)async{
    String url='https://fakestoreapi.com/products/category/$categoryname';
  Response response= await  dio.get(url);
  List<dynamic> products  = response.data;
  products.map((e) => Product.fromJson(e)).toList();
  }
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Future<List<Product>>getAllProducts()async{
   String url='https://fakestoreapi.com/products';
   Response response=await dio.get(url);
   List<Product> products  = response.data;
   return products;
  }
  ////////////////////////////////////////////////////////////////////////////////////////////////

  Future<Product>getSingleProduct(String num)async{
   String url= 'https://fakestoreapi.com/products/$num';
   Response response= await  dio.get(url);
   Product product =response.data;
   return product;
  }
////////////////////////////////////////////////////////////////////////////////////////////////

}