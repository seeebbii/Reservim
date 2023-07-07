import 'package:reservim/core/model/shops/deals.model.dart';

class AllDealsModel {
  List<DealsModel>? bestDeals;
  List<DealsModel>? bestDealsWomen;
  List<DealsModel>? bestDealsMen;
  List<DealsModel>? fiftyPercentDeals;
  List<DealsModel>? twentyPercentDeals;

  AllDealsModel(
      {this.bestDeals,
      this.bestDealsWomen,
      this.bestDealsMen,
      this.fiftyPercentDeals,
      this.twentyPercentDeals});

// AllDealsModel.fromJson(Map<String, dynamic> json){
//     this.id = json['id'];
//     this.name = json['name'];
// }
//
// Map<String, dynamic> toJson() => {'id':id, 'name':name };
}
