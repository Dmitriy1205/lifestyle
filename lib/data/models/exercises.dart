class Exercises {
  final String? image;
  final String? name;
  final String? duration;
  final String? timeValue;

  Exercises({
    this.image,
    this.name,
    this.duration,
    this.timeValue,
  });

  factory Exercises.fromJson(Map<String, dynamic> json) {
    return Exercises(
      image: json["image"].toString(),
      name: json["name"].toString(),
      duration: json["duration"].toString(),
      timeValue: json["timeValue"].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "image": image,
      "name": name,
      "duration": duration,
      "timeValue": timeValue,
    };
  }
}
