class OpeningClosingHours {
  int? id;
  String? day;
  List<String>? end;
  List<String>? start;
  bool? status;

  OpeningClosingHours({this.id, this.day, this.end, this.start, this.status});

  OpeningClosingHours.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    day = json['day'];
    end = json['end'].cast<String>();
    start = json['start'].cast<String>();
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['day'] = day;
    data['end'] = end;
    data['start'] = start;
    data['status'] = status;
    return data;
  }
}