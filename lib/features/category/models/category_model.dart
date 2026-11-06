class CategoryModel {
  String? category;
  List<Items>? items;

  CategoryModel({this.category, this.items});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? name;
  int? price;
  String? description;
  String? image;
  int qty;

  Items({this.name, this.price, this.description, this.image, this.qty = 1,});

  Items.fromJson(Map<String, dynamic> json)
      : qty = 1 {
    name = json['name'];
    price = json['price'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    data['description'] = this.description;
    data['image'] = this.image;
    data['qty'] = qty;
    return data;
  }
}
