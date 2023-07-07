class FilterModel {

  String? name;
  bool? isSelected = false;

  FilterModel({ this.name, this.isSelected });

  // FilterModel.fromJson(Map<String, dynamic> json){
  //     this.id = json['id'];
  //     this.name = json['name'];
  // }
  //
  // Map<String, dynamic> toJson() => {'id':id, 'name':name };
}