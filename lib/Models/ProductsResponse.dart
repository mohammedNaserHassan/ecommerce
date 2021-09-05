class Product {
  int _id;
  String _title;
  num _price;
  String _description;
  String _category;
  String _image;
  Rating _rating;

  Product(
      {int id,
        String title,
        int price,
        String description,
        String category,
        String image,
        Rating rating}) {
    this._id = id;
    this._title = title;
    this._price = price;
    this._description = description;
    this._category = category;
    this._image = image;
    this._rating = rating;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get title => _title;
  set title(String title) => _title = title;
  int get price => _price;
  set price(int price) => _price = price;
  String get description => _description;
  set description(String description) => _description = description;
  String get category => _category;
  set category(String category) => _category = category;
  String get image => _image;
  set image(String image) => _image = image;
  Rating get rating => _rating;
  set rating(Rating rating) => _rating = rating;

  Product.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _title = json['title'];
    _price = json['price'];
    _description = json['description'];
    _category = json['category'];
    _image = json['image'];
    _rating =
    json['rating'] != null ? new Rating.fromJson(json['rating']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['title'] = this._title;
    data['price'] = this._price;
    data['description'] = this._description;
    data['category'] = this._category;
    data['image'] = this._image;
    if (this._rating != null) {
      data['rating'] = this._rating.toJson();
    }
    return data;
  }
}

class Rating {
  num _rate;
  int _count;

  Rating({double rate, int count}) {
    this._rate = rate;
    this._count = count;
  }

  double get rate => _rate;
  set rate(double rate) => _rate = rate;
  int get count => _count;
  set count(int count) => _count = count;

  Rating.fromJson(Map<String, dynamic> json) {
    _rate = json['rate'];
    _count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rate'] = this._rate;
    data['count'] = this._count;
    return data;
  }
}