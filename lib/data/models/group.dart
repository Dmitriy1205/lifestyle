import 'exercises.dart';

class Group {
  Exercises? exercise;
  String? relaxTime;

  Group({this.exercise, this.relaxTime});

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      exercise: json["exercise"] == null
          ? null
          : Exercises.fromJson(json["exercise"] as Map<String, dynamic>),
      relaxTime: json["relaxTime"].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "exercise": exercise?.toJson(),
      "relaxTime": relaxTime,
    };
  }
}
