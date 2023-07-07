class BlogModel {
  String? title;
  String? subtitle;
  DateTime? dateTime;
  int? readDuration;
  int? views;
  String? imagePath;

  BlogModel({this.title, this.subtitle, this.dateTime, this.readDuration, this.views, this.imagePath});

  BlogModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
    dateTime = json['dateTime'];
    readDuration = json['readDuration'];
    views = json['views'];
    imagePath = json['imagePath'];
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'subtitle': subtitle,
        'dateTime': dateTime,
        'readDuration': readDuration,
        'views': views,
        'imagePath': imagePath,
      };
}
