class ServicePriceHistory {
  List<String>? name;
  List<int>? price;

  ServicePriceHistory({this.name, this.price});

  ServicePriceHistory.fromJson(Map<String, dynamic> json) {
    name = json['name'].cast<String>();
    price = json['price'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['price'] = price;
    return data;
  }
}