class TimeSlotModel {

  String? timeSlot;
  bool? isSelected;

  TimeSlotModel({ this.timeSlot, this.isSelected });

  TimeSlotModel.fromJson(Map<String, dynamic> json){
      timeSlot = json['timeSlot'];
      isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() => {'timeSlot':timeSlot, 'isSelected':isSelected };
}