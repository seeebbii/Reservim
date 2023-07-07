class CategoriesModel {

  String? imagePath;
  String? name;
  bool? isSelected;

  CategoriesModel({ this.imagePath, this.name, this.isSelected });

  CategoriesModel.fromJson(Map<String, dynamic> json){
    imagePath = json['imagePath'];
    name = json['name'];
    isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() => {'imagePath':imagePath, 'name':name , 'isSelected': isSelected};
}